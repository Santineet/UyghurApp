//
//  NewsCVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class NewsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedTitle))
            self.titleNews.isUserInteractionEnabled = true
            self.titleNews.addGestureRecognizer(tap)
        }
    }
    
    var new: NewsModel? {
        didSet {
            if self.new!.video_url != "" {
                self.playImage.isHidden = false
                self.imageNews.sd_setImage(with: URL(string: new!.video_preview_url))
            } else if self.new?.image_url != "" {
                self.playImage.isHidden = true
                self.imageNews.sd_setImage(with: URL(string: new!.image_url))
            }
            
            self.titleNews.text = new!.title
        }
    }
    
    
    var link: NewsTVCell?
    
    @objc func didTappedTitle() {
        self.link?.didTappedTitle(new: self.new!)
    }
    
}
