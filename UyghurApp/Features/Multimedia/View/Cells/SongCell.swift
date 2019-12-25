//
//  songCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/25/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet weak var songIV: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playIV: UIImageView!
    
    var audio: Audio? {
        didSet {
            self.songName.text = audio?.audio_name
            self.artistName.text = audio?.artist_name
            if audio?.audio_image_url != "" {
                self.songIV.sd_setImage(with: URL(string: audio!.audio_image_url), placeholderImage: UIImage(named: "ic_audio"))
            } else { self.songIV.image = UIImage(named: "ic_audio") }
        }
    }
    
}
