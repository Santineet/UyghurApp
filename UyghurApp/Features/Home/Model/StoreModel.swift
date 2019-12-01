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
    var image_urls = [imageUrl]()
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

class imageUrl: NSObject,Mappable {
    
    var height: Int = 0
    var width: Int = 0
    var image_name: String = ""
    var image_url: String = ""
    var name: String = ""
    
    required convenience init?(map: Map) {
          self.init()
      }

      func mapping(map: Map) {

        height <- map["height"]
        width <- map["width"]
        image_name <- map["image_name"]
        image_url <- map["image_url"]
        name <- map["name"]
        
      }
    
}
