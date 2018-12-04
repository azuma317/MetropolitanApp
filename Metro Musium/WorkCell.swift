//
//  WorkCell.swift
//  Metro Musium
//
//  Created by Azuma on 2018/11/19.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Kingfisher

class WorkCell: UITableViewCell {

    @IBOutlet weak var workImageView: UIImageView!
    @IBOutlet weak var workNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    func configure(work: Work) {
        workNameLabel.text = work.title
        nameLabel.text = work.artistName
        guard let url = URL(string: work.imagePath!) else { return }
        workImageView.kf.setImage(with: url)
    }

}