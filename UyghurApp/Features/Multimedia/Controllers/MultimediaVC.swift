//
//  MultimediaVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/24/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import RxSwift

class MultimediaVC: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var allVideosLabel: UILabel!
    @IBOutlet weak var allAudiosLabel: UILabel!
    
    @IBOutlet weak var videosLabel: UILabel!
    @IBOutlet weak var audiosLable: UILabel!
    let songCell = "songCell"
    let videoCell = "videoCell"
    
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    var multimediaVM: MultimediaVM?
    let dispose = DisposeBag()
    
    var filteredVideos = [Video]()
    var videos = [Video]() {
        didSet {
            DispatchQueue.main.async { self.videosCollectionView.reloadData() }
        }
    }
    
    var searchBarIsEmpty:Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    var isFiltering:Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var filteredAudios = [Audio]()
    var audios = [Audio]() {
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
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
    
    var infoViewForAudios: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 0.12)
        view.layer.cornerRadius = 12
        return view
    }()
    
    var infoTextViewForAudios: UITextView = {
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
        
        let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.playerDetailsView.multimediaDelegate = self
        
        setupListeners()
        setupUI()
        setupInfoViewForVideos()
        setupInfoViewForAudios()
    }
    
//    var playingIndex: Int?
//    var playing: Bool = false
//
    fileprivate func setupInfoViewForVideos() {
        
        videosCollectionView.addSubview(infoViewForVideos)
        let sizeForEstimate = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: "emptySearchResultLabel".localized).boundingRect(with: sizeForEstimate, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], context: nil)
        
        infoViewForVideos.anchor(top: videosCollectionView.topAnchor, left: videosCollectionView.leftAnchor, bottom: nil, right: videosCollectionView.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: estimatedFrame.width + 16, height: estimatedFrame.height + 36)
        infoViewForVideos.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInfoTextViewForVideos()
    }
    
    fileprivate func setupInfoTextViewForVideos() {
        
        infoViewForVideos.addSubview(infoTextViewForVideos)
        infoTextViewForVideos.text = "emptySearchResultLabel".localized
        infoTextViewForVideos.anchor(top: infoViewForVideos.topAnchor, left: infoViewForVideos.leftAnchor, bottom: infoViewForVideos.bottomAnchor, right: infoViewForVideos.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    
    fileprivate func setupInfoViewForAudios() {
        
        tableView.addSubview(infoViewForAudios)
        let sizeForEstimate = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: "emptySearchResultLabel".localized).boundingRect(with: sizeForEstimate, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], context: nil)
        
        infoViewForAudios.anchor(top: tableView.topAnchor, left: tableView.leftAnchor, bottom: nil, right: tableView.rightAnchor, paddingTop: 320, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: estimatedFrame.width + 16, height: estimatedFrame.height + 36)
        infoViewForAudios.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInfoTextViewForAudios()
    }
    
    fileprivate func setupInfoTextViewForAudios() {
        
        infoViewForAudios.addSubview(infoTextViewForAudios)
        infoTextViewForAudios.text = "emptySearchResultLabel".localized
        infoTextViewForAudios.anchor(top: infoViewForAudios.topAnchor, left: infoViewForAudios.leftAnchor, bottom: infoViewForAudios.bottomAnchor, right: infoViewForAudios.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "multimediaNavTitle".localized
        self.allVideosLabel.text = "allLabel".localized
        self.allAudiosLabel.text = "allLabel".localized
        self.videosLabel.text = "videosLabel".localized
        self.audiosLable.text = "audiosLabel".localized
        searchController.searchBar.placeholder = "searchPlaceholder".localized
    }
    
    func setupInfoViewForVideosHidden(isHidden: Bool) {
        
        infoViewForVideos.isHidden = isHidden
        infoTextViewForVideos.isHidden = isHidden
    }
    
    func setupInfoViewForAudiosHidden(isHidden: Bool) {
        
        infoViewForAudios.isHidden = isHidden
        infoTextViewForAudios.isHidden = isHidden
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
        let cell = videosCollectionView.dequeueReusableCell(withReuseIdentifier: videoCell, for: indexPath) as! VideoCell
        
        var video: Video
        if isFiltering {
            video = self.filteredVideos[indexPath.row]
        } else { video =  self.videos[indexPath.item] }
        cell.video = video
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var video: Video
        HidePlayer.instance.hide()

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
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.audios.count == 0 {
            self.setupInfoViewForAudiosHidden(isHidden: false)
            return 0
        }
        if isFiltering {
            if self.filteredAudios.count == 0 {
                self.setupInfoViewForAudiosHidden(isHidden: false)
                return 0
            }
        }
        
        self.setupInfoViewForAudiosHidden(isHidden: true)
        return isFiltering ? filteredAudios.count : self.audios.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: songCell, for: indexPath) as! SongCell
        var audio: Audio
        if isFiltering {
            audio = self.filteredAudios[indexPath.row]
        } else { audio =  self.audios[indexPath.item] }
        cell.audio = audio
        
        if let index = playingIndex, index == indexPath.row {
            
            if playing {
                let pauseImage = UIImage(systemName: "pause.fill")
               cell.playIV.image = pauseImage
            } else {
                let playImage = UIImage(systemName: "play.fill")
                cell.playIV.image = playImage
            }
        } else {
            let playImage = UIImage(systemName: "play.fill")
            cell.playIV.image = playImage
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var audio: Audio

        if isFiltering {
            audio = self.filteredAudios[indexPath.row]
        } else { audio =  self.audios[indexPath.item] }
              
        let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
//                mainTabBarController?.playerDetailsView.delegate = self

        mainTabBarController?.playerDetailsView.isHidden = false
        mainTabBarController?.maximizePlayerDetails(song: audio, playlistSongs: audios)
        playingIndex = indexPath.row
        playing = true
        self.tableView.reloadData()
    }
}

extension MultimediaVC: ChangeMultimediaPlayerTrackDelegate {
    func changePlayingTrack(type: TypeOfChange) {
        switch  type {
        case .Next:
           if playingIndex != nil {
//                playing = true
//                playingIndex! += 1
                self.tableView.reloadData()
            }
        case .Pause:
//            playing = false
            self.tableView.reloadData()
        case .Previous:
            if playingIndex != nil {
//                playingIndex! -= 1
                self.tableView.reloadData()
            }
        case .NewPlaylist:
            if playingIndex != nil {
//                playing = true
//                playingIndex! = 0
                self.tableView.reloadData()
            }
        case .PlayFromTheEnd:
            if playingIndex != nil {
//                let count = self.audios.count
//                playingIndex! = count - 1
                self.tableView.reloadData()
             }
            
        case .Play:
//            playing = true
            self.tableView.reloadData()
        }
    }
}
