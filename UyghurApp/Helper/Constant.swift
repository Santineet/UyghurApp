//
//  Constant.swift
//  BffClient
//
//  Created by Avazbek Kodiraliev on 6/12/19.
//  Copyright © 2019 Avazbek Kodiraliev. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
  
    static let MAIN_STORYBOARD = "Main"
    static let ADMIN_STORYBOARD = "Auth"
    static let USER_TOKEN_KEY = "token"
    static let BACKEND_ERROR = NSError.init(message: "Произошла ошибка, пожалуйста переавторизуйтесь")
    
    static let englishLanguage = "en"
    static let russianLanguage = "ru"
    static let kyrgyzLanguage = "ky"
    static let applicationCurrentLanguage = "appCurrentLanguage"
    static let languageDictionary = [Constants.englishLanguage:"English", Constants.russianLanguage:"Русский", Constants.kyrgyzLanguage:"Кыргыз"]
    static let languageDictionaryKeys = [Constants.englishLanguage:"EN", Constants.russianLanguage:"RU", Constants.kyrgyzLanguage:"KY"]
}
