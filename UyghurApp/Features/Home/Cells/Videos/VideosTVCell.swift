//
//  VideosTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVFoundation

class VideosTVCell: UITableViewCell {

    
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var videos = [VideosModel]()
//    private var images = [UIImage]()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupColletionView()
    }

    //MARK: - setup ColletionView 
    private func setupColletionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func allVideos(_ sender: UIButton) {
    
    }

}

extension VideosTVCell: UICollectionViewDataSource, UICollectionViewDelegate {
   
    //MARK: -  UICollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
        
    }
    
    //MARK: -  UICollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let video = self.videos[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCVCell", for: indexPath) as! VideosCVCell
        cell.title.text = video.title
        
        if let thumbnailIndex = video.thumbnailIndex {
            cell.imagePreview.image = video.images[thumbnailIndex]
        } else {
            cell.imagePreview.image = UIImage(named: "videoPlayer")
        }
        
        return cell
    }
}

extension VideosTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: -  UICollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }

        
}
