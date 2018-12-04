//
//  WorkListController.swift
//  Metro Musium
//
//  Created by Azuma on 2018/11/19.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class WorkListController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var works: [Work] = []
    var tempWorks: [Work] = []

    let pages: [Int] = Array(1...30)
    let pickerView = UIPickerView()
    var selectedPage = 1
    var workIDs: [Int] = []

    @IBOutlet weak var pageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolbarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolBar.items = [toolbarButton]
        pageTextField.inputAccessoryView = toolBar

        loadWork()
    }

    @objc func done() {
        loadWork()
        pageTextField.resignFirstResponder()
    }

    func loadWork() {
        guard let path = Bundle.main.path(forResource: "\(selectedPage)", ofType: "txt") else { return }
        guard let workID = try? String(contentsOfFile: path, encoding: .utf8) else { return }
        self.workIDs = []
        workID.enumerateLines(invoking: { (workID, _) in
            guard let id = Int(workID) else { return }
            self.workIDs.append(id)
        })
        tasks()
    }

    func tasks() {
        tempWorks = []
        for id in workIDs {
            let url = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(id)")
            URLSession.shared.dataTask(with: url!) { (data, _, _) in
                guard let data = data else { return }
                do {
                    let work = try JSONDecoder().decode(Work.self, from: data)
                    if work.isTrue() && !(self.tempWorks.last?.artistName == work.artistName && self.tempWorks.last?.title == work.title) {
                        self.tempWorks.append(work)
                        DispatchQueue.main.async {
                            if self.tempWorks.count % 25 == 0 {
                                self.works = self.tempWorks
                                self.tableView.reloadData()
                            }
                        }
                    }
                } catch {
                    print(error)
                }
                }.resume()
        }
    }

    @IBAction func textFieldEditing(_ sender: UITextField) {
        sender.inputView = pickerView
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pages.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pages[row])Page"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPage = pages[row]
        pageTextField.text = "\(pages[row])Page"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return works.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath) as! WorkCell

        cell.selectionStyle = .none
        cell.configure(work: works[indexPath.item])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: works[indexPath.item])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let work = sender as? Work else { return }
        guard let vc = segue.destination as? DetailController else { return }
        vc.imagePath = work.imagePath
        vc.workName = work.title
        vc.artistName = work.artistName
        vc.date = work.date
        vc.classification = work.classification
    }

}
