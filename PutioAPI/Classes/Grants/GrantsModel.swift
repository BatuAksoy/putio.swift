//
//  GrantsModel.swift
//  Putio
//
//  Created by Altay Aydemir on 9.11.2017.
//  Copyright © 2017 Put.io. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct PutioOAuthGrant {
    let id: Int
    let name: String
    let description: String
    let website: URL?

    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.website = json["website"].url
    }
}
