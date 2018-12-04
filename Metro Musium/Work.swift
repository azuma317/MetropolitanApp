//
//  Work.swift
//  Metro Musium
//
//  Created by Azuma on 2018/11/19.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation

struct Work: Decodable {
    var id: Int?
    var isPublic: Bool?
    var imagePath: String?
    var artistName: String?
    var title: String?
    var classification: String?
    var date: String?
    var medium: String?
    var url: String?

    private enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case isPublic = "isPublicDomain"
        case imagePath = "primaryImage"
        case artistName = "artistDisplayName"
        case title
        case classification
        case date = "objectDate"
        case medium
        case url = "objectURL"
    }

    func isTrue() -> Bool {
        return id != nil && isPublic ?? false && !(imagePath?.isEmpty ?? true) && !(artistName?.isEmpty ?? true) && !(title?.isEmpty ?? true) && !(classification?.isEmpty ?? true) && !(date?.isEmpty ?? true)
    }
}
