//
//  StoreDetailVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreDetailVC {
    
    func setupUI() {
        
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
