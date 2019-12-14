//
//  FIRRefManager.swift
//  UyghurApp
//
//  Created by Mairambek on 11/23/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Firebase
import FirebaseFirestore

enum Route:String{
    case dictionary_categories
    case dictionary_words
    case news
    case videos
    case audios
    case store
    case histories
    case translations
    case contacts
}

enum EventType {
    case Added
    case Changed
    case Removed
}

class FIRRefManager: NSObject {
    
    static let instance = FIRRefManager()
    let dicCategoriesRef = Firestore.firestore().collection(Route.dictionary_categories.rawValue)
    let dicWordsRef = Firestore.firestore().collection(Route.dictionary_words.rawValue)
    let newsRef = Firestore.firestore().collection(Route.news.rawValue)
    let audiosRef = Firestore.firestore().collection(Route.audios.rawValue)
    let videosRef = Firestore.firestore().collection(Route.videos.rawValue)
    let storeRef = Firestore.firestore().collection(Route.store.rawValue)
    let historiesRef = Firestore.firestore().collection(Route.histories.rawValue)
    let translationsRef = Firestore.firestore().collection(Route.translations.rawValue)
    let contactsRef = Firestore.firestore().collection(Route.contacts.rawValue)
}
