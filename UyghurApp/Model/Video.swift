//
//  Video.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class Video: NSObject, Mappable {
    
    var id: String = ""
    var video_title: String = ""
    var video_preview_url: String = ""
    var video_url: String = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        video_title <- map["title"]
        video_url <- map["video_url"]
        video_preview_url <- map["preview_image"]
    }
    
}
