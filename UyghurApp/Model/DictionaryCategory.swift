//
//  DictionaryCategories.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/25/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class DictionaryCategory: NSObject, Mappable {
    
    var id:String = ""
    var category_name: String = ""
    var song_name: String = ""
    var category_audio_url: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        category_name <- map["category_name"]
        song_name <- map["song_name"]
        category_audio_url <- map["category_audio_url"]
    }
    
}
