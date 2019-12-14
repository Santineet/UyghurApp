//
//  StoreModel.swift
//  UyghurApp
//
//  Created by Mairambek on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import ObjectMapper

class StoreModel: NSObject,Mappable {
    
    var id: String = ""
    var descriptionStore :String = ""
    var image_urls = [Image]()
    var name: String = ""
    var price: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        descriptionStore <- map["descriptionStore"]
        image_urls <- map["image_urls"]
        name <- map["name"]
        price <- map["price"]
        
    }
}
