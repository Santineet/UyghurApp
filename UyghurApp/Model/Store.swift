//
//  Store.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class Store: NSObject, Mappable {
    
    var id:String = ""
    var product_name: String = ""
    var product_description: String = ""
    var product_price: String = ""
    var images = [Image]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        product_name <- map["name"]
        product_description <- map["description"]
        product_price <- map["price"]
        images <- map["image_urls"]
    }
}

class Image: NSObject, Mappable {
    
    var height: Int = 0
    var width: Int = 0
    var image_url: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        height <- map["height"]
        width <- map["width"]
        image_url <- map["image_url"]
    }

}
