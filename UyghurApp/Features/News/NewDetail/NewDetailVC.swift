//
//  NewDetailVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/24/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

class NewDetailVC: UIViewController {

    @IBOutlet weak var newImageOrVideo: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var newText: UITextView!
    
    var newTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    var new: New?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        guard let new = self.new else { return }
        setValuesToLabels(new)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setValueToLocalizedLabels()
    }
    
    @IBAction func didTappedPlayButton(_ sender: Any) {
        if new!.video_url != "" {
            presentToAVPlayerVC()
        }
    }
    
}
