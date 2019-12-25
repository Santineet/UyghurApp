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
    @IBOutlet weak var playVideoIV: UIImageView!
    
    var new: New? {
        didSet {
            self.readButton.setTitle("readLabel".localized, for: .normal)
            self.newTitle.text = new?.title
            self.newDescription.text = new?.new_description
            if new!.video_url != "" {
                DispatchQueue.main.async {
                    self.newImageOrVideo.sd_setImage(with: URL(string: self.new!.video_preview_url))
                }
                self.playVideoIV.isHidden = false
            }
            
            if new!.image_url != "" {
                self.newImageOrVideo.sd_setImage(with: URL(string: self.new!.image_url))
                self.playVideoIV.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        
        newImageOrVideo.isUserInteractionEnabled = true
        newTitle.isUserInteractionEnabled = true
        newDescription.isUserInteractionEnabled = true
        readButton.isUserInteractionEnabled = true
        playVideoIV.isUserInteractionEnabled = true
        
        newImageOrVideo.layer.cornerRadius = 8
        newImageOrVideo.layer.masksToBounds = true
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    @IBAction func didTappedReadButton(_ sender: Any) {
        link?.didTappedReadButton(new: self.new)
    }
    
}
