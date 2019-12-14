//
//  HomeVC + fetchData.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/7/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import PKHUD

extension HomeVC {
    
    func fetchData() {
        HUD.show(.progress)
        
        self.getCategories()
        self.getNews()
        self.getVideos()
        self.getAudios()
        self.getProducts()
        self.getHistories()
    }
    
    
    //MARK: - request Histories
    fileprivate func getHistories(){
        
        homeVM.getHistories { (error) in
            if let error = error {
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.historiesBR.skip(1).subscribe(onNext: { (historiesArray) in
            self.histories = historiesArray
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        homeVM.errorhistoriesBR.skip(1).subscribe(onNext: { (error) in
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
        HUD.hide()
    }
    
    
    //MARK: - request Products
    fileprivate func getProducts(){
        homeVM.getStoreProducts { (error) in
            if let error = error {
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.storeBR.skip(1).subscribe(onNext: { (productsArray) in
            self.products = productsArray
        }).disposed(by: disposeBag)
        
        homeVM.errorStoreBR.skip(1).subscribe(onNext: { (error) in
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
        HUD.hide()
    }
    
    //MARK: - request DicCategories
    fileprivate func getCategories() {
        homeVM.getDicCategories { (error) in
            if let error = error {
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
            
        }
        
        homeVM.categoriesBR.skip(1).subscribe(onNext: { (categoriesArray) in
            HUD.hide()
            self.categories = categoriesArray
        }).disposed(by: disposeBag)
        
        homeVM.errorCategoriesBR.skip(1).subscribe(onNext: { (error) in
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
        HUD.hide()
    }
    
    //MARK: - request Videos
    fileprivate func getVideos() {
        homeVM.getVideos { (error) in
            if let error = error {
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.videosBR.skip(1).subscribe(onNext: { (videosArray) in
            HUD.hide()
            self.videos = videosArray
        }).disposed(by: disposeBag)
        
        homeVM.errorVideosBR.skip(1).subscribe(onNext: { (error) in
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
        HUD.hide()
    }
    
    //MARK: - request Audios
    fileprivate func getAudios() {
        homeVM.getAudios { (error) in
            if let error = error {
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.audiosBR.skip(1).subscribe(onNext: { (audiosArray) in
            HUD.hide()
            self.audios = audiosArray
        }).disposed(by: disposeBag)
        
        homeVM.errorAudiosBR.skip(1).subscribe(onNext: { (error) in
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
        HUD.hide()
    }
    
    //MARK: - request News
    fileprivate func getNews(){
        homeVM.getNews { (error) in
            if let error = error {
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.newsBR.skip(1).subscribe(onNext: { (newsArray) in
            self.news = newsArray
        }).disposed(by: disposeBag)
        
        homeVM.errorNewsBR.skip(1).subscribe(onNext: { (error) in
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
        HUD.hide()
    }
}
