//
//  NewsModel.swift
//  UyghurApp
//
//  Created by Mairambek on 11/23/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//
//

import ObjectMapper

class NewsModel: NSObject,Mappable {
   
    var id:String = ""
    var title: String = ""
    var name_image: String = ""
    var video_url: String = ""
    var image_url: String = ""
    var descriptionVideo: String = ""
    var images = [UIImage]()
    var thumbnailIndex: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        name_image <- map["name_image"]
        video_url <- map["video_url"]
        image_url <- map["image_url"]
        descriptionVideo <- map["description"]

    }

}
