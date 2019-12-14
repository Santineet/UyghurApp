//
//  HomeVC + functions.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/7/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

extension HomeVC {
    
    func didTappedAllDictionariesLabel() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DictionaryVC") as? DictionaryVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func didTappedDictionary(dictCategory: DictionaryCategoriesModel) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DictDetailVC") as? DictDetailVC {
            if let navigator = navigationController {
                let newDictCategory = DictionaryCategory()
                newDictCategory.id = dictCategory.id
                newDictCategory.category_name = dictCategory.category_name
                newDictCategory.category_audio_url = dictCategory.category_audio_url
                viewController.dictionaryCategory = newDictCategory
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func didTappedAllNewsLabel() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsVC") as? NewsVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func didTappedNew(new: NewsModel) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewDetailVC") as? NewDetailVC {
            if let navigator = navigationController {
                let newNew = New()
                newNew.id = new.id
                newNew.image_url = new.image_url
                newNew.video_url = new.video_url
                newNew.title = new.title
                newNew.new_description = new.descriptionVideo
                viewController.new = newNew
                navigator.pushViewController(viewController, animated: true) }
        }
    }

    func didTappedNewVideo(url: String) {
        
        let player = AVPlayer(url: URL(string: url)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func didTappedVideosLabel() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideosVC") as? VideosVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func didTappedVideo(url: String) {
        
        let player = AVPlayer(url: URL(string: url)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func didTappedAllAudiosLabel() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudiosVC") as? AudiosVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func didTappedAllProductsLabel() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreVC") as? StoreVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func didTappedProduct(product: StoreModel) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreDetailVC") as? StoreDetailVC {
            if let navigator = navigationController {
                let newProduct = Store()
                newProduct.id = product.id
                newProduct.images = product.image_urls
                newProduct.product_name = product.name
                newProduct.product_price = product.price
                newProduct.product_description = product.descriptionStore
                viewController.store = newProduct
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func didTappedAllHistoriesLabel() {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoriesVC") as? HistoriesVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func didTappedHistoryLabel(history: HistoriesModel) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryDetailVC") as? HistoryDetailVC {
            if let navigator = navigationController {
                let newHistory = History()
                newHistory.history_title = history.title
                newHistory.history_image_url = history.image_url
                newHistory.history_description = history.descriptionHistory
                viewController.history = newHistory
                navigator.pushViewController(viewController, animated: true) }
        }
    }
}
