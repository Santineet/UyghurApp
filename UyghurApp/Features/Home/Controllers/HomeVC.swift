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
import SPStorkController
import AVFoundation
import SwiftAudio

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let homeVM = HomeViewModel()
    private var news = [NewsModel]()
    private let disposeBag = DisposeBag()
    private var audios = [AudiosModel]()
    private var videos = [VideosModel]()
    private var categories = [DictionaryCategoriesModel]()
    private var products = [StoreModel]()
    private var histories = [HistoriesModel]()

    let dispatchGroup = DispatchGroup()
    
    //MARK: - Player Utils
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playActivityIndicat: UIActivityIndicatorView!

    var playerr: AVPlayer?
    let audioPlayer = AudioPlayer()
    var playr = AVAudioPlayer()
    var player = AVAudioPlayer()
    var playing = false
    var playingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Главная"
        self.playerView.isHidden = true
        setupTableView()
        fetchData()
//        setupPlayer()
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
        dispatchGroup.enter()
        getHistories()
        dispatchGroup.notify(queue: .main) {
            
            self.tableView.reloadData()
            HUD.hide()
        }
        
    }

    //MARK: - request Histories
    private func getHistories(){
        
        homeVM.getHistories { (error) in
            if let error = error {
                self.dispatchGroup.leave()
                Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }
        }
        
        homeVM.historiesBR.skip(1).subscribe(onNext: { (historiesArray) in
            self.histories = historiesArray
            self.dispatchGroup.leave()
            }).disposed(by: disposeBag)
        
        homeVM.errorhistoriesBR.skip(1).subscribe(onNext: { (error) in                self.dispatchGroup.leave()
            Alert.displayAlert(title: "", message: error.localizedDescription, vc: self)
            }).disposed(by: disposeBag)
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
        return 6
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
            cell.link = self
            cell.collectionView.reloadData()
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTVCell", for: indexPath) as! ProductsTVCell
            cell.selectionStyle = .none
            cell.products = self.products
            cell.collectionView.reloadData()
            
            return cell
        case 5:
            if histories.count >= 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTVCell", for: indexPath) as! HistoryTVCell
                cell.selectionStyle = .none
                cell.firstImage.sd_setImage(with: URL(string: self.histories[0].image_url ), placeholderImage: nil)
                cell.firstTitle.text = self.histories[0].title
                
                cell.secondImage.sd_setImage(with: URL(string: self.histories[1].image_url), placeholderImage: nil)
                cell.secondTitle.text = self.histories[1].title
                cell.thirdImage.sd_setImage(with: URL(string: self.histories[2].image_url), placeholderImage: nil)
                cell.thirdTitle.text = self.histories[2].title
                
                return cell
            }
            
            return UITableViewCell()
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
        case 5:
            return 345
        default:
            return 100
        }
    }
    
}


extension HomeVC {
    //MARK: - Player
    
    func playPressed(collectionIndex: Int, indexPathRow: Int){
        let index = indexPathRow + collectionIndex * 3
        let audio = self.audios[index]
        guard let url = URL(string: audio.audio_url + ".mp3") else {
            print("return")
            return
        }
        self.songNameLabel.text = audio.name
        self.playerImage.sd_setImage(with: URL(string: audio.image_url), placeholderImage: nil)
        self.pauseButton.isHidden = true
        self.playerView.isHidden = false
        self.playActivityIndicat.isHidden = false
        self.playActivityIndicat.startAnimating()
        
        
        playy(url: url,index: index)
        
        //        downloadFileFromURL(url: url)
        
    }
    
    
    //    func downloadFileFromURL(url: URL){
    //
    //         var downloadTask: URLSessionDownloadTask
    //         downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](url, response, error) in
    //             guard let url = url else { return }
    //             self?.play(url: url)
    //         })
    //
    //         downloadTask.resume()
    //
    //     }
    
    //    func setupPlayer(){
    //        audioPlayer.event.stateChange.addListener(self, handleAudioPlayerStateChange)
    //
    //    }
    //
    //    func handleAudioPlayerStateChange(state: AudioPlayerState) {
    //        print(";sldkf';lkdf;'sdkfsdkfp3[412-e059-23=049-=w0e9r=42-0qe9r")
    //    }
    //
    
    
    
    
    
    
    
    
    func playy(url: URL, index: Int){
        
        print("playing \(url)")
        
        
        if playerr != nil, let oldIndex  = self.playingIndex  {
            if index == oldIndex {
                if playing   {
                    print("pause")
                    self.playing = !self.playing
                    playerr!.pause()
                } else {
                    self.playing = !self.playing
                    print("play 6576576")
                    playerr!.play()
                }
            }
        } else {
            
            
            
            let playerItem = AVPlayerItem(url: url)
    
            self.playerr = AVPlayer(playerItem:playerItem)
            playerr!.volume = 1.0
            self.playingIndex = index
            if playing {
                print("pause")
                self.playing = !self.playing
                playerr!.pause()
            } else {
                self.playing = !self.playing
                print("play")
                playerr!.play()
            }
        }
        self.pauseButton.isHidden = false
        self.playActivityIndicat.stopAnimating()
        self.playActivityIndicat.isHidden = true

        //                self.playerr = nil
           
    }
//
//
//    func downloadFileFromURL(url: URL){
//
//        var downloadTask:URLSessionDownloadTask
//        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
//            self?.playy(url: URL!)
//        })
//
//        downloadTask.resume()
//
//    }
//
    
//     func play(url: URL) {
//              print("playing \(url)")
//
//           DispatchQueue.main.async {
//
//           do {
//
//            self.player = try AVAudioPlayer(contentsOf: url)
//            if self.player.isPlaying {
//                self.player.stop()
//                      self.player = try AVAudioPlayer(contentsOf: url)
//                  }
//                  self.player.prepareToPlay()
//                  self.player.volume = 1.0
//                  self.player.play()
//              } catch let error as NSError {
////                  self.player = nil
//                self.playerView.isHidden = true
//                Alert.displayAlert(title:"", message: "Произошла ошибка", vc: self)
//
//                print(error.localizedDescription)
//              } catch {
//                Alert.displayAlert(title: "", message: "Произошла ошибка", vc: self)
//                self.playerView.isHidden = true
//                  print("AVAudioPlayer init failed")
//              }
//
//          }
//    }


}

