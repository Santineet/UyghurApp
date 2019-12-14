//
//  VideoCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/25/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

class VideoCell: UICollectionViewCell {
    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoIV: UIImageView!
    
    var video: Video? {
        didSet {
            self.videoTitle.text = video?.video_title
            if video!.video_url != "" {
                DispatchQueue.main.async {
                    //self.videoIV.image = self.createThumbnailOfVideoFromRemoteUrl(url: self.video!.video_url)
                }
            }
        }
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
