//
//  DictionaryCategoriesModel.swift
//  UyghurApp
//
//  Created by Mairambek on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import ObjectMapper

class DictionaryCategoriesModel: NSObject,Mappable {
   
    var id: String = ""
    var audio_name:String = ""
    var category_audio_url: String = ""
    var category_name: String = ""
    var song_name: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {

        id <- map["id"]
        audio_name <- map["audio_name"]
        category_audio_url <- map["category_audio_url"]
        category_name <- map["category_name"]
        song_name <- map["song_name"]

    }

}
