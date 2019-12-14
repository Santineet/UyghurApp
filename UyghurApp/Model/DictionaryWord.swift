//
//  Dictionary.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class DictionaryWord: NSObject, Mappable {
    
    var id:String = ""
    var category_name: String = ""
    var russian_word: String = ""
    var uyghur_word: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        category_name <- map["category_name"]
        russian_word <- map["russian_word"]
        uyghur_word <- map["uyghur_word"]
    }
    
}
