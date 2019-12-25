//
//  VideosModel.swift
//  UyghurApp
//
//  Created by Mairambek on 11/30/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import ObjectMapper

class VideosModel: NSObject,Mappable {
    
    var id:String = ""
    var title: String = ""
    var video_name: String = ""
    var video_url: String = ""
    var video_preview_url: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        video_name <- map["video_name"]
        video_url <- map["video_url"]
        video_preview_url <- map["preview_image"]
    }
    
}
