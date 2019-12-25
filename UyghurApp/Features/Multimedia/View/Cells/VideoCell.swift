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
                    self.videoIV.sd_setImage(with: URL(string: self.video!.video_preview_url))
                }
            }
        }
    }
}
