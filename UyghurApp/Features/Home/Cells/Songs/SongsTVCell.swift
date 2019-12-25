//
//  SongsTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class SongsTVCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var audiosLabel: UILabel!
    @IBOutlet weak var allAudiosLabel: UILabel!
    
    var audios = [Audio]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var link: HomeVC?
//    var playingIndex: Int?
//    var playing: Bool = false
//
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedAllAudiosLabel))
        self.allAudiosLabel.isUserInteractionEnabled = true
        self.allAudiosLabel.addGestureRecognizer(tap)
        
        let mainTabBarController =  UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.playerDetailsView.homeDelegate = self
        
        setupCollectionView()
    }
    
    @objc func didTappedAllAudiosLabel() {
        HidePlayer.instance.hide()

        self.link?.didTappedAllAudiosLabel()
    }
    
    
    //MARK: - setup CollectionView
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension SongsTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - CollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return audios.count
    }
    
    //MARK: - CollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongsCVCell", for: indexPath) as! SongsCVCell
        let audio = audios[indexPath.row]
        cell.nameLabel.text = audio.audio_name
        cell.singerLabel.text = audio.artist_name
        cell.songImageView.sd_setImage(with: URL(string: audio.audio_image_url), placeholderImage: UIImage(named: "ic_audio"))
        cell.playButton.isEnabled = false
        if let index = playingIndex, index == indexPath.row {
            
            if playing {
                let pauseImage = UIImage(systemName: "pause.fill")
                cell.playButton.setImage(pauseImage, for: .normal)
            } else {
                let playImage = UIImage(systemName: "play.fill")
                cell.playButton.setImage(playImage, for: .normal)
            }
            
            
        } else {
            let playImage = UIImage(systemName: "play.fill")
            cell.playButton.setImage(playImage, for: .normal)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let song = audios[indexPath.row]
        let mainTabBarController =  UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.maximizePlayerDetails(song: song, playlistSongs: audios)
        mainTabBarController?.playerDetailsView.isHidden = false

        playing = true
        playingIndex = indexPath.row
        
        collectionView.reloadData()
    }
    
    
    func playingNextPreck(){
        if playingIndex != nil {
            playingIndex! += 1
            self.collectionView.reloadData()
        }
    }
    
    func playingPreviousPreck(){
        if playingIndex != nil {
            playingIndex! -= 1
            self.collectionView.reloadData()
        }
    }
    
    
}

extension SongsTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
    }
}

extension SongsTVCell: ChangeHomePlayerTrackDelegate {
    func changePlayingTrack(type: TypeOfChange) {
        
        switch type {
        case .Next:
            
            if playingIndex != nil {
                playingIndex! += 1
                self.collectionView.reloadData()
            }
            
        case .Previous:
            if playingIndex != nil {
                playingIndex! -= 1
                self.collectionView.reloadData()
            }
        case .Pause:
            playing = false
            self.collectionView.reloadData()
        case .NewPlaylist:
            if playingIndex != nil {
                playingIndex! = 0
                self.collectionView.reloadData()
            }
        case .PlayFromTheEnd:
            if playingIndex != nil {
                let count = audios.count
                playingIndex = count - 1
                self.collectionView.reloadData()
            }
            
        case .Play:
            playing = true
            self.collectionView.reloadData()
        }
    }
}

