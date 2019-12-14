//
//  HomeViewModel.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/6/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: NSObject {
    
    let dispose = DisposeBag()
    let newsBR = BehaviorRelay<[NewsModel]>(value: [])
    let audiosBR = BehaviorRelay<[Audio]>(value: [])
    let videosBR = BehaviorRelay<[VideosModel]>(value: [])
    let categoriesBR = BehaviorRelay<[DictionaryCategoriesModel]>(value: [])
    let storeBR = BehaviorRelay<[StoreModel]>(value: [])
    let historiesBR = BehaviorRelay<[HistoriesModel]>(value: [])
    let errorStoreBR = BehaviorRelay<Error>(value: NSError.init())
    let errorhistoriesBR = BehaviorRelay<Error>(value: NSError.init())
    let errorCategoriesBR = BehaviorRelay<Error>(value: NSError.init())
    let errorNewsBR = BehaviorRelay<Error>(value: NSError.init())
    let errorAudiosBR = BehaviorRelay<Error>(value: NSError.init())
    let errorVideosBR = BehaviorRelay<Error>(value: NSError.init())
    
    private let repository = HomeRepository()
    
    func getNews(completion: @escaping (Error?) -> ()) {
        if Network.instance.isConnected() == true {
            repository.getNews().subscribe(onNext: { (newsArray) in
                self.newsBR.accept(newsArray)
            }, onError: { (error) in
                self.errorNewsBR.accept(error)
            }).disposed(by: dispose)
        } else {
            completion(NSError.init(message: "Для получения данных требуется подключение к интернету"))
        }
    }
    
    func getAudios(completion: @escaping (Error?) -> ()){
        if Network.instance.isConnected() == true {
            HomeServiceManager.instance.getAudios { (audiosArray, error) in
                if let error = error {
                    self.errorAudiosBR.accept(error)
                } else {
                    guard let audios = audiosArray as? [Audio] else { return }
                    
                    self.audiosBR.accept(audios)
                }
                
            }
        } else {
            completion(NSError.init(message: "Для получения данных требуется подключение к интернету"))
        }
    }
    
    func getVideos(completion: @escaping (Error?) -> ()){
        if Network.instance.isConnected() == true {
            HomeServiceManager.instance.getVideos { (videosArray, error) in
                
                if let error = error {
                    self.errorVideosBR.accept(error)
                } else {
                    guard let videos = videosArray as? [VideosModel] else { return }
                    
                    self.videosBR.accept(videos)
                }
            }
        } else {
            completion(NSError.init(message: "Для получения данных требуется подключение к интернету"))
        }
    }
    
    func getDicCategories(completion: @escaping (Error?) -> ()){
        if Network.instance.isConnected() == true {
            HomeServiceManager.instance.getDicCategories { (categoriesArray, error) in
                
                if let error = error {
                    self.errorCategoriesBR.accept(error)
                } else {
                    guard let categories = categoriesArray as? [DictionaryCategoriesModel] else { return }
                    self.categoriesBR.accept(categories)
                }
            }
        } else {
            completion(NSError.init(message: "Для получения данных требуется подключение к интернету"))
        }
    }
    
    func getStoreProducts(completion: @escaping (Error?) -> ()){
        if Network.instance.isConnected() == true {
            HomeServiceManager.instance.getStoreProducts { (productsArray, error) in
                
                if let error = error {
                    self.errorStoreBR.accept(error)
                } else {
                    guard let products = productsArray as? [StoreModel] else { return }
                    self.storeBR.accept(products)
                }
            }
        } else {
            completion(NSError.init(message: "Для получения данных требуется подключение к интернету"))
        }
    }
    
    func getHistories(completion: @escaping (Error?) -> ()){
        if Network.instance.isConnected() == true {
            HomeServiceManager.instance.getHistories { (historyArray, error) in
                
                if let error = error {
                    self.errorhistoriesBR.accept(error)
                } else {
                    guard let histories = historyArray as? [HistoriesModel] else { return }
                    self.historiesBR.accept(histories)
                }
            }
        } else {
            completion(NSError.init(message: "Для получения данных требуется подключение к интернету"))
        }
    }
    
    
}

