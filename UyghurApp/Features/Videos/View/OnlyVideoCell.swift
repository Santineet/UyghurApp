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
    
    @IBOutlet weak var videoIV: UIImageView!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var playOrPauseIV: UIImageView!
    
    var video: Video? {
        didSet {
            self.videoDescription.text = video?.video_title
            if video!.video_url != "" {
                DispatchQueue.main.async {
                    self.videoIV.sd_setImage(with: URL(string: self.video!.video_preview_url))
                }
            }
        }
    }
    
}
