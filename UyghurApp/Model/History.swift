//
//  History.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class History: NSObject, Mappable {
    
    var id:String = ""
    var history_title: String = ""
    var history_description: String = ""
    var history_important: String = ""
    var history_image_url: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        history_title <- map["title"]
        history_description <- map["description"]
        history_important <- map["important"]
        history_image_url <- map["image_url"]
    }
    
}

