//
//  HistoriesModel.swift
//  UyghurApp
//
//  Created by Mairambek on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import ObjectMapper

class HistoriesModel: NSObject,Mappable {
   
    var id: String = ""
    var descriptionHistory :String = ""
    var image_name: String = ""
    var image_url: String = ""
    var important: Bool?
    var title: String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {

        id <- map["id"]
        descriptionHistory <- map["description"]
        image_name <- map["image_name"]
        image_url <- map["image_url"]
        important <- map["important"]
        title <- map["title"]

    }

}
