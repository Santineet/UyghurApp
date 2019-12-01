//
//  HomeVC.swift
//  UyghurApp
//
//  Created by Mairambek on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift
import PKHUD

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let homeVM = HomeViewModel()
    private var news = [NewsModel]()
    private let disposeBag = DisposeBag()
    private var audios = [AudiosModel]()
    private var videos = [VideosModel]()
    private var categories = [DictionaryCategoriesModel]()
    private var products = [StoreModel]()
    
    let dispatchGroup = DispatchGroup()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Главная"
        setupTableView()
        fetchData()
    }
    
    //MARK: - setup TableView
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - fetch Data
    private func fetchData() {
        HUD.show(.progress)
        
        dispatchGroup.enter()
        getAudios()
        dispatchGroup.enter()
        getNews()
        dispatchGroup.enter()
        getVideos()
        dispatchGroup.enter()
        getCategories()
        dispatchGroup.enter()
        getProducts()
        dispatchGroup.notify(queue: .main) {
            
            self.tableView.reloadData()
            HUD.hide()
        }
        
    }

    
    //MARK: - request Products
    private func getProducts(){
        homeVM.getStoreProducts { (error) in
            if let error = error {
                self.dispatchGroup.leave()
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.storeBR.skip(1).subscribe(onNext: { (productsArray) in
            self.products = productsArray
            self.dispatchGroup.leave()
            }).disposed(by: disposeBag)
        
        homeVM.errorStoreBR.skip(1).subscribe(onNext: { (error) in
            self.dispatchGroup.leave()
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }).disposed(by: disposeBag)
    }
    
    //MARK: - request DicCategories
    private func getCategories(){
        homeVM.getDicCategories { (error) in
            if let error = error {
                self.dispatchGroup.leave()
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.categoriesBR.skip(1).subscribe(onNext: { (categoriesArray) in
            self.categories = categoriesArray
            print("category \(self.categories.count)")
            self.dispatchGroup.leave()
        }).disposed(by: disposeBag)
        
        homeVM.errorCategoriesBR.skip(1).subscribe(onNext: { (error) in
            self.dispatchGroup.leave()
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
    }
    
    //MARK: - request Videos
    private func getVideos(){
        homeVM.getVideos { (error) in
            if let error = error {
                self.dispatchGroup.leave()
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.videosBR.skip(1).subscribe(onNext: { (videosArray) in
            self.videos = videosArray
            self.dispatchGroup.leave()
        }).disposed(by: disposeBag)
        
        homeVM.errorVideosBR.skip(1).subscribe(onNext: { (error) in
            self.dispatchGroup.leave()
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
    }
    
    //MARK: - request Audios
    private func getAudios(){
        homeVM.getAudios { (error) in
            if let error = error {
                self.dispatchGroup.leave()
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.audiosBR.skip(1).subscribe(onNext: { (audiosArray) in
            self.audios = audiosArray
            self.dispatchGroup.leave()
        }).disposed(by: disposeBag)
        
        homeVM.errorAudiosBR.skip(1).subscribe(onNext: { (error) in
            self.dispatchGroup.leave()
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
    }
    
    //MARK: - request News
    private func getNews(){
        homeVM.getNews { (error) in
            if let error = error {
                self.dispatchGroup.leave()
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.newsBR.skip(1).subscribe(onNext: { (newsArray) in

            self.news = newsArray
            self.dispatchGroup.leave()
        }).disposed(by: disposeBag)
        
        homeVM.errorNewsBR.skip(1).subscribe(onNext: { (error) in
            self.dispatchGroup.leave()
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
        }).disposed(by: disposeBag)
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryTVCell", for: indexPath) as! DictionaryTVCell
            cell.selectionStyle = .none
            cell.categories = self.categories
            cell.collectionView.reloadData()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVCell", for: indexPath) as! NewsTVCell
            cell.selectionStyle = .none
            cell.newsArray = self.news
            cell.collectionView.reloadData()
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideosTVCell", for: indexPath) as! VideosTVCell
            cell.selectionStyle = .none
            cell.videos = self.videos
            cell.collectionView.reloadData()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongsTVCell", for: indexPath) as! SongsTVCell
            cell.selectionStyle = .none
            cell.audios = self.audios
            cell.collectionView.reloadData()
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTVCell", for: indexPath) as! ProductsTVCell
            cell.selectionStyle = .none
            cell.products = self.products
            cell.collectionView.reloadData()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    //MARK: - heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 185
        case 1:
            return 235
        case 2:
            return 310
        case 3:
            return 210
        case 4:
            return 260
        default:
            return 100
        }
    }
    
    
}