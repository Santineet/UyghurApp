//
//  HistoryTVCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/6/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class HistoryTVCell: UITableViewCell {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var thirdTitle: UILabel!
    
    @IBOutlet weak var historiesLabel: UILabel!
    @IBOutlet weak var allHistoriesLabel: UILabel!
    
    var link: HomeVC?
    
    var histories = [HistoriesModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedAllHistoriesLabel))
        self.allHistoriesLabel.isUserInteractionEnabled = true
        self.allHistoriesLabel.addGestureRecognizer(tap)
        
        let firstIVTap = UITapGestureRecognizer(target: self, action: #selector(didTappedFirstIV))
        self.firstImage.isUserInteractionEnabled = true
        self.firstImage.addGestureRecognizer(firstIVTap)
        
        let secondIVTap = UITapGestureRecognizer(target: self, action: #selector(didTappedSecondIV))
        self.secondImage.isUserInteractionEnabled = true
        self.secondImage.addGestureRecognizer(secondIVTap)
        
        let thirdIVTap = UITapGestureRecognizer(target: self, action: #selector(didTappedThirdIV))
        self.thirdImage.isUserInteractionEnabled = true
        self.thirdImage.addGestureRecognizer(thirdIVTap)
    }

    @objc func didTappedAllHistoriesLabel() {
        HidePlayer.instance.hide()

        self.link?.didTappedAllHistoriesLabel()
    }
    
    @objc func didTappedFirstIV() {
        HidePlayer.instance.hide()

        if self.histories.count >= 1 {
            self.link?.didTappedHistoryLabel(history: self.histories[0])
        }
    }
    
    @objc func didTappedSecondIV() {
        HidePlayer.instance.hide()

        if self.histories.count >= 2 {
            self.link?.didTappedHistoryLabel(history: self.histories[1])
        }
    }
    
    @objc func didTappedThirdIV() {
        HidePlayer.instance.hide()

        if self.histories.count >= 3 {
            self.link?.didTappedHistoryLabel(history: self.histories[2])
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
