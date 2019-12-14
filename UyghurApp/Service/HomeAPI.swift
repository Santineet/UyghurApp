//
//  HomeAPI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/7/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import ObjectMapper

class HomeAPI {
    
    static let instance = HomeAPI()
    
    func setupDictinaryCategoriesListener(onSuccess: @escaping(EventType, DictionaryCategoriesModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.dicCategoriesRef.addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let dictionaryCategorie = Mapper<DictionaryCategoriesModel>().map(JSON: value) {
                        dictionaryCategorie.id = documentChange.document.documentID
                        onSuccess(.Added ,dictionaryCategorie)
                    }
                } else if documentChange.type == .modified {
                    if let dictionaryCategorie = Mapper<DictionaryCategoriesModel>().map(JSON: value) {
                        dictionaryCategorie.id = documentChange.document.documentID
                        onSuccess(.Changed ,dictionaryCategorie)
                    }
                } else if documentChange.type == .removed {
                    if let dictionaryCategorie = Mapper<DictionaryCategoriesModel>().map(JSON: value) {
                        dictionaryCategorie.id = documentChange.document.documentID
                        onSuccess(.Removed ,dictionaryCategorie)
                    }
                }
            })
        }
    }
    
    
    
    func setupNewsListener(onSuccess: @escaping(EventType, NewsModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.newsRef.addSnapshotListener { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let new = Mapper<NewsModel>().map(JSON: value) {
                        new.id = documentChange.document.documentID
                        onSuccess(.Added ,new)
                    }
                } else if documentChange.type == .modified {
                    if let new = Mapper<NewsModel>().map(JSON: value) {
                        new.id = documentChange.document.documentID
                        onSuccess(.Changed ,new)
                    }
                } else if documentChange.type == .removed {
                    if let new = Mapper<NewsModel>().map(JSON: value) {
                        new.id = documentChange.document.documentID
                        onSuccess(.Removed ,new)
                    }
                }
            })
        }
    }
    
    
    func setupVideosListener(onSuccess: @escaping(EventType, VideosModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.videosRef.addSnapshotListener { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let video = Mapper<VideosModel>().map(JSON: value) {
                        video.id = documentChange.document.documentID
                        onSuccess(.Added, video)
                    }
                } else if documentChange.type == .modified {
                    if let video = Mapper<VideosModel>().map(JSON: value) {
                        video.id = documentChange.document.documentID
                        onSuccess(.Changed, video)
                    }
                } else if documentChange.type == .removed {
                    if let video = Mapper<VideosModel>().map(JSON: value) {
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
    
    func setupStoreListener(onSuccess: @escaping(EventType, StoreModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.storeRef.addSnapshotListener { (querySnapshot, error) in
            
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let value = documentChange.document.data()
                if documentChange.type == .added {
                    if let store = Mapper<StoreModel>().map(JSON: value) {
                        store.id = documentChange.document.documentID
                        onSuccess(.Added, store)
                    }
                } else if documentChange.type == .modified {
                    if let store = Mapper<StoreModel>().map(JSON: value) {
                        store.id = documentChange.document.documentID
                        onSuccess(.Changed, store)
                    }
                } else if documentChange.type == .removed {
                    if let store = Mapper<StoreModel>().map(JSON: value) {
                        store.id = documentChange.document.documentID
                        onSuccess(.Removed, store)
                    }
                }
            })
        }
    }
    
    func setupHistoriesListener(onSuccess: @escaping(EventType, History) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        FIRRefManager.instance.historiesRef.limit(to: 3).addSnapshotListener { (querySnapshot, error) in
            
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
    
}
