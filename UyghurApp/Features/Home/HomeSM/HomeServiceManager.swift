//
//  ServiceManager.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/6/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import AVFoundation
import ObjectMapper


class HomeServiceManager: NSObject {
    
    static let instance = HomeServiceManager()
    typealias Completion = (_ response: Any?, _ error: Error?) -> ()
    typealias onCompletion =  ((EventType, NewsModel) -> Void)
  
    func getHistories(completion: @escaping Completion){
        
        FIRRefManager.instance.historiesRef.getDocuments { (querySnapshot, error) in
                        
            if let error = error {
                completion(nil, error)
            } else {
                
           guard let snapshot = querySnapshot else { return }
                var histories = [HistoriesModel]()
                for document in snapshot.documents {
                    guard let history = Mapper<HistoriesModel>().map(JSON: document.data()) else { return }
                    histories.append(history)
                    if histories.count == snapshot.documents.count {
                        completion(histories, nil)
                    }
                }
            }
        }
    }
    
    
    func getStoreProducts(completion: @escaping Completion){
        
        FIRRefManager.instance.storeRef.getDocuments { (querySnapshot, error) in
                        
            if let error = error {
                completion(nil, error)
            } else {
                
           guard let snapshot = querySnapshot else { return }
                var products = [StoreModel]()
                for document in snapshot.documents {
                    guard let product = Mapper<StoreModel>().map(JSON: document.data()) else { return }
                    products.append(product)
                    if products.count == snapshot.documents.count {
                        completion(products, nil)
                    }
                }
            }
        }
    }
    
    
    
    func getDicCategories(completion: @escaping Completion){
        
        FIRRefManager.instance.dicCategoriesRef.getDocuments { (querySnapshot, error) in
                        
            if let error = error {
                completion(nil, error)
            } else {
                
           guard let snapshot = querySnapshot else { return }
                var categories = [DictionaryCategoriesModel]()
                for document in snapshot.documents {
                    guard let category = Mapper<DictionaryCategoriesModel>().map(JSON: document.data()) else { return }
                    categories.append(category)
                    if categories.count == snapshot.documents.count {
                        completion(categories, nil)
                    }
                }
            }
        }
    }
    
    
    func getNews(completion: @escaping Completion){
        
        FIRRefManager.instance.newsRef.getDocuments { (querySnapshot, error) in
                        
            if let error = error {
                completion(nil, error)
            } else {
                
           guard let snapshot = querySnapshot else {return}
                var newsArray = [NewsModel]()
                for document in snapshot.documents {
                 
                    guard let news = Mapper<NewsModel>().map(JSON: document.data()) else { return }
                    
                    if news.video_url != "", let url = URL(string: news.video_url){
                        
                    }
                    
                    newsArray.append(news)
                    if newsArray.count == snapshot.documents.count {
                        completion(newsArray, nil)
                    }
                }
            }
        }
    }
    
    func getAudios(completion: @escaping Completion){
        
        FIRRefManager.instance.audiosRef.getDocuments { (querySnapshot, error) in
                        
            if let error = error {
                completion(nil, error)
            } else {
                
           guard let snapshot = querySnapshot else {return}
                var audiosArray = [Audio]()
                for document in snapshot.documents {
                    guard let audio = Mapper<Audio>().map(JSON: document.data()) else { return }
                    audiosArray.append(audio)
                    if audiosArray.count == snapshot.documents.count {
                        completion(audiosArray, nil)
                    }
                }
            }
        }
    }
    
    func getVideos(completion: @escaping Completion){
         
         FIRRefManager.instance.videosRef.getDocuments { (querySnapshot, error) in
                         
             if let error = error {
                 completion(nil, error)
             } else {
                 
            guard let snapshot = querySnapshot else {return}
                 var videosArray = [VideosModel]()
                 for document in snapshot.documents {
                     guard let video = Mapper<VideosModel>().map(JSON: document.data()) else { return }
                   
                    if let url = URL(string:  video.video_url){
                    }

                    
                     videosArray.append(video)
                     if videosArray.count == snapshot.documents.count {
                         completion(videosArray, nil)
                     }
                 }
             }
         }
     }
    
}

