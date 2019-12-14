//
//  VideoCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

class OnlyVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var videoIV: UIImageView! {
        didSet {
            self.videoIV.layer.backgroundColor = UIColor.white.cgColor
            self.videoIV.layer.shadowColor = UIColor.lightGray.cgColor
            self.videoIV.layer.shadowOffset = .zero
            self.videoIV.layer.shadowRadius = 7.0
            self.videoIV.layer.shadowOpacity = 0.8
            self.videoIV.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var playOrPauseIV: UIImageView!
    
    var video: Video? {
        didSet {
            self.videoDescription.text = video?.video_title
            if video!.video_url != "" {
                DispatchQueue.main.async {
                    //self.videoIV.image = self.createThumbnailOfVideoFromRemoteUrl(url: self.video!.video_url)
                }
            }
        }
    }
    
    fileprivate func setupViewShaddow() {
         
         self.layer.cornerRadius = 7
         self.layer.backgroundColor = UIColor.white.cgColor
         self.layer.shadowColor = UIColor.gray.cgColor
         self.layer.shadowOffset = .zero
         self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
         self.layer.shadowRadius = 3.0
         self.layer.shadowOpacity = 1.0
         self.layer.masksToBounds = false
     }
    
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 500)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch { return nil }
    }
    
}
