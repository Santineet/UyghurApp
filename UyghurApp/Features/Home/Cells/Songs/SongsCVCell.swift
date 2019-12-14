//
//  SongsCVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class SongsCVCell: UICollectionViewCell {
    
//    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var audios = [Audio]()
    var index = 0
    var link: HomeVC?
    var playingSection: Int?
    var playingIndex: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
    
