//
//  VideosCVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class VideosCVCell: UICollectionViewCell {
    
    @IBOutlet weak var pauseImage: UIImageView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    var video: VideosModel?{
        didSet {
            self.imagePreview.sd_setImage(with: URL(string: video!.video_preview_url))
            self.title.text = self.video?.title
        }
    }
    
}
