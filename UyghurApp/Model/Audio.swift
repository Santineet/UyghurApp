//
//  Audio.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class Audio: NSObject, Mappable {
    
    var id:String = ""
    var audio_name: String = ""
    var artist_name: String = ""
    var audio_url: String = ""
    var audio_image_url: String = ""
    var audio_text_arab: String = ""
    var audio_text_kiril: String = ""
    var audio_text_latin: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        audio_name <- map["name"]
        artist_name <- map["artist_name"]
        audio_image_url <- map["image_url"]
        audio_url <- map["audio_url"]
        audio_text_kiril <- map["text_kiril"]
        audio_text_arab <- map["text_arab"]
        audio_text_latin <- map["text_latin"]
    }
    
}
