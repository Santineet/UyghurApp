//
//  Translation.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/26/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class Translation: NSObject, Mappable {
    
    var id:String = ""
    var russian_word: String = ""
    var latin_word: String = ""
    var cyrillic_word: String = ""
    var arab_word: String = ""
    var audio_url: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        russian_word <- map["russian_word"]
        latin_word <- map["latin_word"]
        cyrillic_word <- map["cyrillic_word"]
        arab_word <- map["arabic_word"]
        audio_url <- map["audio_url"]
    }
    
}
