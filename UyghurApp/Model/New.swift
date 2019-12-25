//
//  New.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/26/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class New: NSObject, Mappable {
    
    var id:String = ""
    var title: String = ""
    var image_url: String = ""
    var height: Int = 0
    var width: Int = 0
    var video_url: String = ""
    var video_preview_url: String = ""
    var new_description: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image_url <- map["image_url"]
        height <- map["height"]
        width <- map["width"]
        video_url <- map["video_url"]
        new_description <- map["description"]
        video_preview_url <- map["preview_image"]
    }
    
}

