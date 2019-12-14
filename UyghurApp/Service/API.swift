//
//  API.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/25/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class API {
    
    static let instance = API()
    
    func setupDictinaryCategoriesListener(onSuccess: @escaping(EventType, DictionaryCategory) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.dicCategoriesRef.addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let dictionaryCategorie = Mapper<DictionaryCategory>().map(JSON: value) {
                        dictionaryCategorie.id = documentChange.document.documentID
                        onSuccess(.Added ,dictionaryCategorie)
                    }
                } else if documentChange.type == .modified {
                    if let dictionaryCategorie = Mapper<DictionaryCategory>().map(JSON: value) {
                        dictionaryCategorie.id = documentChange.document.documentID
                        onSuccess(.Changed ,dictionaryCategorie)
                    }
                } else if documentChange.type == .removed {
                    if let dictionaryCategorie = Mapper<DictionaryCategory>().map(JSON: value) {
                        dictionaryCategorie.id = documentChange.document.documentID
                        onSuccess(.Removed ,dictionaryCategorie)
                    }
                }
            })
        }
    }
    
    func setupDictinaryWordsListener(category_name: String, onSuccess: @escaping(EventType, DictionaryWord) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.dicWordsRef.whereField("category_name", isEqualTo: category_name).addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let dictionaryWord = Mapper<DictionaryWord>().map(JSON: value) {
                        dictionaryWord.id = documentChange.document.documentID
                        onSuccess(.Added ,dictionaryWord)
                    }
                } else if documentChange.type == .modified {
                    if let dictionaryWord = Mapper<DictionaryWord>().map(JSON: value) {
                        dictionaryWord.id = documentChange.document.documentID
                        onSuccess(.Changed ,dictionaryWord)
                    }
                } else if documentChange.type == .removed {
                    if let dictionaryWord = Mapper<DictionaryWord>().map(JSON: value) {
                        dictionaryWord.id = documentChange.document.documentID
                        onSuccess(.Removed ,dictionaryWord)
                    }
                }
            })
        }
    }
    
    
    func setupTranslationsListener(onSuccess: @escaping(EventType, Translation) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.translationsRef.order(by: "russian_word", descending: false).getDocuments { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let translation = Mapper<Translation>().map(JSON: value) {
                        translation.id = documentChange.document.documentID
                        onSuccess(.Added ,translation)
                    }
                } else if documentChange.type == .modified {
                    if let translation = Mapper<Translation>().map(JSON: value) {
                        translation.id = documentChange.document.documentID
                        onSuccess(.Changed ,translation)
                    }
                } else if documentChange.type == .removed {
                    if let translation = Mapper<Translation>().map(JSON: value) {
                        translation.id = documentChange.document.documentID
                        onSuccess(.Removed ,translation)
                    }
                }
            })
        }
    }
    
    
    
    func setupNewsListener(onSuccess: @escaping(EventType, New) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.newsRef.addSnapshotListener { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let new = Mapper<New>().map(JSON: value) {
                        new.id = documentChange.document.documentID
                        onSuccess(.Added ,new)
                    }
                } else if documentChange.type == .modified {
                    if let new = Mapper<New>().map(JSON: value) {
                        new.id = documentChange.document.documentID
                        onSuccess(.Changed ,new)
                    }
                } else if documentChange.type == .removed {
                    if let new = Mapper<New>().map(JSON: value) {
                        new.id = documentChange.document.documentID
                        onSuccess(.Removed ,new)
                    }
                }
            })
        }
    }
    
    
    func setupStoreListener(onSuccess: @escaping(EventType, Store) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.storeRef.addSnapshotListener { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let store = Mapper<Store>().map(JSON: value) {
                        store.id = documentChange.document.documentID
                        onSuccess(.Added, store)
                    }
                } else if documentChange.type == .modified {
                    if let store = Mapper<Store>().map(JSON: value) {
                        store.id = documentChange.document.documentID
                        onSuccess(.Changed, store)
                    }
                } else if documentChange.type == .removed {
                    if let store = Mapper<Store>().map(JSON: value) {
                        store.id = documentChange.document.documentID
                        onSuccess(.Removed, store)
                    }
                }
            })
        }
    }
    
    func setupHistoriesListener(onSuccess: @escaping(EventType, History) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.historiesRef.addSnapshotListener { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let history = Mapper<History>().map(JSON: value) {
                        history.id = documentChange.document.documentID
                        onSuccess(.Added, history)
                    }
                } else if documentChange.type == .modified {
                    if let history = Mapper<History>().map(JSON: value) {
                        history.id = documentChange.document.documentID
                        onSuccess(.Changed, history)
                    }
                } else if documentChange.type == .removed {
                    if let history = Mapper<History>().map(JSON: value) {
                        history.id = documentChange.document.documentID
                        onSuccess(.Removed, history)
                    }
                }
            })
        }
    }
    
    func setupVideosListener(onSuccess: @escaping(EventType, Video) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.videosRef.addSnapshotListener { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let video = Mapper<Video>().map(JSON: value) {
                        video.id = documentChange.document.documentID
                        onSuccess(.Added, video)
                    }
                } else if documentChange.type == .modified {
                    if let video = Mapper<Video>().map(JSON: value) {
                        video.id = documentChange.document.documentID
                        onSuccess(.Changed, video)
                    }
                } else if documentChange.type == .removed {
                    if let video = Mapper<Video>().map(JSON: value) {
                        video.id = documentChange.document.documentID
                        onSuccess(.Removed, video)
                    }
                }
            })
        }
    }
    
    func setupAudiosListener(onSuccess: @escaping(EventType, Audio) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.audiosRef.addSnapshotListener { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let audio = Mapper<Audio>().map(JSON: value) {
                        audio.id = documentChange.document.documentID
                        onSuccess(.Added, audio)
                    }
                } else if documentChange.type == .modified {
                    if let audio = Mapper<Audio>().map(JSON: value) {
                        audio.id = documentChange.document.documentID
                        onSuccess(.Changed, audio)
                    }
                } else if documentChange.type == .removed {
                    if let audio = Mapper<Audio>().map(JSON: value) {
                        audio.id = documentChange.document.documentID
                        onSuccess(.Removed, audio)
                    }
                }
            })
        }
    }
    
}
