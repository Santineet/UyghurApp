//
//  NewDetailVC + functions.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

extension NewDetailVC {
    
    func setValuesToLabels(_ new: New) {
        
        setValueToNewImageOrVideoView(new)
        setValueToNewtextView(new)
    }
    
    fileprivate func setValueToNewImageOrVideoView(_ new: New) {
        
        if new.image_url != "" {
            DispatchQueue.main.async {
                self.newImageOrVideo.sd_setImage(with: URL(string: self.new!.image_url))
                self.playButton.isHidden = true
            }
        } else if new.video_url != "" {
            DispatchQueue.main.async {
                //self.newImageOrVideo.image = self.createThumbnailOfVideoFromRemoteUrl(url: new.video_url)
                self.playButton.isHidden = false
            }
            
        }
    }
    
    fileprivate func setValueToNewtextView(_ new: New) {
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        
        let attributed = NSMutableAttributedString(string: new.title + "\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 20), .foregroundColor : UIColor.black, NSAttributedString.Key.paragraphStyle: style])
        
        attributed.append(NSMutableAttributedString(string: new.new_description, attributes: [.font : UIFont.systemFont(ofSize: 18, weight: .regular), .foregroundColor : UIColor.lightGray, NSAttributedString.Key.paragraphStyle: style]))
        
        self.newText.attributedText = attributed
    }
    
    
    func setValueToLocalizedLabels() {
        
        navigationItem.title = "infoNavTitle".localized
    }
    
    func presentToAVPlayerVC() {
        
        let player = AVPlayer(url: URL(string: new!.video_url)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.maximumSize = CGSize(width: view.frame.width/3, height: (self.view.frame.width-18)/2)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch { return nil }
    }
}
