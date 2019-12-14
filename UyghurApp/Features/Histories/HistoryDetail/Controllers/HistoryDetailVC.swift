//
//  HistoryDetailVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class HistoryDetailVC: UIViewController {

    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var historyIV: UIImageView!
    @IBOutlet weak var historyDescription: UITextView!
    
    var history: History?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let history = self.history else {
            return
        }
        
        self.historyLabel.text = history.history_title
        self.historyIV.sd_setImage(with: URL(string: history.history_image_url))
        self.historyDescription.text = history.history_description
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "infoNavTitle".localized
    }
    
}
