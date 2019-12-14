//
//  NewDetailVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension NewDetailVC {
    
    func setupUI() {
        
        setupNewTextViewStyle()
    }
    
    func setupNewTextViewStyle() {
        
        self.newText.textAlignment = .center
        self.newText.alwaysBounceVertical = true
    }
}
