//
//  ServiceManager.swift
//  UyghurApp
//
//  Created by Mairambek on 11/23/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//



import Foundation
import AVFoundation
import ObjectMapper

enum EventType {
    case Added
    case Changed
    case Removed
}

class ServiceManager: NSObject {
    
    static let instance = ServiceManager()
    typealias Completion = (_ response: Any?, _ error: Error?) -> ()
    typealias onCompletion =  ((EventType, NewsModel) -> Void)
    
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
                            
                        if let image = self.createThumbnailOfVideoFromRemoteUrl(url: url) {
                            news.thumbnailIndex = news.images.count
                            news.images.append(image)
                            }
                        
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
                var audiosArray = [AudiosModel]()
                for document in snapshot.documents {
                    guard let audio = Mapper<AudiosModel>().map(JSON: document.data()) else { return }
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
                        if let thumbnailImage = self.createThumbnailOfVideoFromRemoteUrl(url: url) {
                            video.thumbnailIndex = video.images.count
                            video.images.append(thumbnailImage)
                        }
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

extension ServiceManager {
    func createThumbnailOfVideoFromRemoteUrl(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(2.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
          print("CreateThumbnail Error \(error.localizedDescription)")
          return nil
        }
    }
}
