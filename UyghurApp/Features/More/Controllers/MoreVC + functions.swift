//
//  MoreVC + functions.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension MoreVC {
    
    func setValueToLocalizedLabels() {
        
        navigationItem.title = "moreNavTitle".localized
        self.dictionaryLabel.text = "dictionaryLabel".localized
        self.translateLabel.text = "translateLabel".localized
        self.storeLabel.text = "storeLabel".localized
        self.newsLabel.text = "newsLabel".localized
        self.historyLabel.text = "historiesLabel".localized
        self.multimadiaLabel.text = "multimedia".localized
        self.aboutUs.text = "aboutUsNavTitle".localized
    }
}
