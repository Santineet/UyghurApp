//
//  VideosTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

class VideosTVCell: UITableViewCell {

    
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var allVideosLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var videos = [VideosModel]()  {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var link: HomeVC?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedVideosLabel))
        self.allVideosLabel.isUserInteractionEnabled = true
        self.allVideosLabel.addGestureRecognizer(tap)
        
        setupColletionView()
    }

    @objc func didTappedVideosLabel() {
        
        self.link?.didTappedVideosLabel()
    }
    
    //MARK: - setup ColletionView
    private func setupColletionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension VideosTVCell: UICollectionViewDataSource, UICollectionViewDelegate {
   
    //MARK: -  UICollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.videos.count == 0 { return 0 }
        return self.videos.count
    }
    
    //MARK: -  UICollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCVCell", for: indexPath) as! VideosCVCell
        let video = self.videos[indexPath.row]
        cell.video = video
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.videos[indexPath.row]
        self.link?.didTappedVideo(url: video.video_url)
    }
}

extension VideosTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: -  UICollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
