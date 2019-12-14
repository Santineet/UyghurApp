//
//  MultimediaVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/4/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension MultimediaVC {
    
    func setupUI() {
        
        setupSearchController()
        setupTableViewStyle()
        setupActionsForLabels()
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
    
    fileprivate func setupTableViewStyle() {
        
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .init(top: 0, left: 1000, bottom: 0, right: 0)
    }
    
    fileprivate func setupActionsForLabels() {
        
        let tapOnAllVideos = UITapGestureRecognizer(target: self, action: #selector(didTappedAllVideosLabel))
        self.allVideosLabel.isUserInteractionEnabled = true
        self.allVideosLabel.addGestureRecognizer(tapOnAllVideos)
        
        let tapOnAllAudios = UITapGestureRecognizer(target: self, action: #selector(didTappedAllAudiosLabel))
        self.allAudiosLabel.isUserInteractionEnabled = true
        self.allAudiosLabel.addGestureRecognizer(tapOnAllAudios)
    }
    
}
