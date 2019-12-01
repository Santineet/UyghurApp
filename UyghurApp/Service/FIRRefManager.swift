//
//  FIRRefManager.swift
//  UyghurApp
//
//  Created by Mairambek on 11/23/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Firebase
import FirebaseFirestore

enum Route: String{
    case audios
    case dictionary_categories
    case dictionary_words
    case histories
    case news
    case store
    case translations
    case videos
}


class FIRRefManager: NSObject {

    static let instance = FIRRefManager()
    let audiosRef = Firestore.firestore().collection(Route.audios.rawValue)
    let dicCategoriesRef = Firestore.firestore().collection(Route.dictionary_categories.rawValue)
    let dicWordsRef = Firestore.firestore().collection(Route.dictionary_words.rawValue)
    let historiesRef = Firestore.firestore().collection(Route.histories.rawValue)
    let newsRef = Firestore.firestore().collection(Route.news.rawValue) 
    let storeRef = Firestore.firestore().collection(Route.store.rawValue)
    let translationsRef = Firestore.firestore().collection(Route.translations.rawValue)
    let videosRef = Firestore.firestore().collection(Route.videos.rawValue)

}
