//
//  VideosVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift
import AVKit

class VideosVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    let onlyVideoCell = "onlyVideoCell"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var multimediaVM: MultimediaVM?
    let dispose = DisposeBag()
    
    var filteredVideos = [Video]()
    var videos = [Video]() {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var infoViewForVideos: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 0.12)
        view.layer.cornerRadius = 12
        return view
    }()
    
    var infoTextViewForVideos: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
        setupVideosListener()
        setupInfoViewForVideos()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func setupInfoViewForVideos() {
         
         collectionView.addSubview(infoViewForVideos)
         let sizeForEstimate = CGSize(width: view.frame.width, height: 1000)
         let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
         let estimatedFrame = NSString(string: "emptySearchResultLabel".localized).boundingRect(with: sizeForEstimate, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], context: nil)
         
         infoViewForVideos.anchor(top: collectionView.topAnchor, left: collectionView.leftAnchor, bottom: nil, right: collectionView.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: estimatedFrame.width + 16, height: estimatedFrame.height + 36)
         infoViewForVideos.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         
         setupInfoTextViewForVideos()
     }
     
     fileprivate func setupInfoTextViewForVideos() {
         
         infoViewForVideos.addSubview(infoTextViewForVideos)
         infoTextViewForVideos.text = "emptySearchResultLabel".localized
         infoTextViewForVideos.anchor(top: infoViewForVideos.topAnchor, left: infoViewForVideos.leftAnchor, bottom: infoViewForVideos.bottomAnchor, right: infoViewForVideos.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "videosNavTitle".localized
        searchController.searchBar.placeholder = "searchPlaceholder".localized
    }
    
    fileprivate func setupVideosListener() {
        
        self.multimediaVM = MultimediaVM()
        self.multimediaVM?.setupVideosListener()
        self.multimediaVM!.videosBR.skip(1).subscribe(onNext: { (eventType, video) in
            switch eventType {
            case .Added:
                if let index = self.videos.firstIndex(where: { (item) -> Bool in
                    return item.id == video.id
                }){
                    self.videos[index] = video
                    self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                } else {
                    self.videos.append(video)
                    self.collectionView.reloadData()
                }
                break
            case .Changed:
                if let index = self.videos.firstIndex(where: { (item) -> Bool in
                    return item.id == video.id
                }){
                    self.videos[index] = video
                    self.collectionView.reloadData()
                }
                break
            case .Removed:
                if let index = self.videos.firstIndex(where: { (item) -> Bool in
                    return item.id == video.id
                }){
                    self.videos.remove(at: index)
                    self.collectionView.reloadData()
                }
                break
            }
        }).disposed(by: dispose)
    }
    
    fileprivate func setupSearchController() {
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func setupInfoViewForVideosHidden(isHidden: Bool) {
        
        infoViewForVideos.isHidden = isHidden
        infoTextViewForVideos.isHidden = isHidden
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.videos.count == 0 {
            self.setupInfoViewForVideosHidden(isHidden: false)
            return 0
        }
        if isFiltering {
            if self.filteredVideos.count == 0 {
                self.setupInfoViewForVideosHidden(isHidden: false)
                return 0
            }
        }
        self.setupInfoViewForVideosHidden(isHidden: true)
        return isFiltering ? filteredVideos.count : self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: onlyVideoCell, for: indexPath) as! OnlyVideoCell
        var video: Video
        if isFiltering {
            video = self.filteredVideos[indexPath.row]
        } else { video =  self.videos[indexPath.item] }
        cell.video = video
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 246)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var video: Video
        if isFiltering {
            video = self.filteredVideos[indexPath.row]
        } else { video =  self.videos[indexPath.item] }
        
        let player = AVPlayer(url: URL(string: video.video_url)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
}

extension VideosVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText:String) {
        
        filteredVideos = self.videos.filter({ (video:Video) -> Bool in
            return video.video_title.lowercased().contains(searchText.lowercased())
        })
        self.collectionView.reloadData()
    }
    
}
