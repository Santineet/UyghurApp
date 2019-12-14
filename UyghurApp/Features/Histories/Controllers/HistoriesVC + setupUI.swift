//
//  HistoriesVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/4/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension HistoriesVC {
    
    func setupUI() {
        
        setupSearchController()
        setupCollectionViewStyle()
    }
    
    fileprivate func setupCollectionViewStyle() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func setupSearchController() {
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
}
