//
//  AudioCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class AudioCell: UITableViewCell {

    
    @IBOutlet weak var audioIV: UIImageView!
    @IBOutlet weak var audioName: UILabel!
    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var playOrPauseIV: UIImageView!
    
    var audio: Audio? {
        didSet {
            self.audioName.text = audio?.audio_name
            self.singerName.text = audio?.artist_name
            if audio?.audio_image_url != "" {
                self.audioIV.sd_setImage(with: URL(string: audio!.audio_image_url), placeholderImage: UIImage(named: "ic_audio"))
            } else { self.audioIV.image = UIImage(named: "ic_audio") }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
