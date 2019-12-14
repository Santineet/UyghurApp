//
//  DictionaryVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension DictionaryVC {
    
    func setupUI() {
        
        setupTableViewStyle()
    }
    
    fileprivate func setupTableViewStyle() {
        
        tableView.tableFooterView = UIView()
        tableView.contentInset = .init(top: 8, left: 0, bottom: 0, right: 0)
    }
}
