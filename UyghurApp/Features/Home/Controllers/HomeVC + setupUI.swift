//
//  HomeVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/7/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension HomeVC {
    
    func setupUI() {
        
        setupTableViewStyle()
    }
    
    
    fileprivate func setupTableViewStyle() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}
