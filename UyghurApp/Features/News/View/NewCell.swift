//
//  NewCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/24/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

class NewCell: UICollectionViewCell {
    
    var link: NewsVC?
    
    @IBOutlet weak var newImageOrVideo: UIImageView!
    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var newDescription: UILabel!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var playVideoButton: UIButton!
    
    var new: New? {
        didSet {
            self.layer.backgroundColor = UIColor.white.cgColor
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOffset = .zero
            self.layer.shadowOpacity = 0.8
            self.layer.masksToBounds = false
            
            self.readButton.setTitle("readLabel".localized, for: .normal)
            self.newTitle.text = new?.title
            self.newDescription.text = new?.new_description
            if new!.video_url != "" {
                //self.newImageOrVideo.image = self.createThumbnailOfVideoFromRemoteUrl(url: self.new!.video_url)
                self.playVideoButton.isHidden = false
            }
            
            if new!.image_url != "" {
                self.newImageOrVideo.sd_setImage(with: URL(string: self.new!.image_url))
                self.playVideoButton.isHidden = true
            }
        }
    }
    
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch { return nil }
    }
    
    override func awakeFromNib() {
        
        newImageOrVideo.isUserInteractionEnabled = true
        newTitle.isUserInteractionEnabled = true
        newDescription.isUserInteractionEnabled = true
        readButton.isUserInteractionEnabled = true
        playVideoButton.isUserInteractionEnabled = true
        
        newImageOrVideo.layer.cornerRadius = 8
        newImageOrVideo.layer.masksToBounds = true
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    @IBAction func didTappedReadButton(_ sender: Any) {
        link?.didTappedReadButton(new: self.new)
    }
    
}


/*
 if new!.video_url != "" {
 DispatchQueue.main.async {
 self.newImageOrVideo.image = self.createThumbnailOfVideoFromRemoteUrl(url: self.new!.video_url)
 self.playVideoButton.isHidden = false
 }
 }
 
 if new!.image_url != "" {
 DispatchQueue.main.async {
 self.newImageOrVideo.sd_setImage(with: URL(string: self.new!.image_url))
 self.playVideoButton.isHidden = true
 }
 }
 */
