//
//  DetailController.swift
//  Metro Musium
//
//  Created by Azuma on 2018/11/20.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Kingfisher

class DetailController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var workNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!

    var imagePath: String?
    var workName: String?
    var artistName: String?
    var date: String?
    var classification: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let imagePath = imagePath else { return }
        imageView.kf.setImage(with: URL(string:imagePath))
        workNameLabel.text = workName
        artistNameLabel.text = artistName
        dateLabel.text = date
        classificationLabel.text = classification
    }
    
    @IBAction func showImage(_ sender: UIButton) {
        performSegue(withIdentifier: "toPhoto", sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoController
        vc.imagePath = imagePath
    }

}
