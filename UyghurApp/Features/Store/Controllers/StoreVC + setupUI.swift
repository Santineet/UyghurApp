//
//  StoreVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreVC {
    
    func setupUI() {
        
        setupSearchController()
        setupCollectionView()
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
    
    fileprivate func setupCollectionView() {
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout { layout.delegate = self }
        collectionView.contentInset = .init(top: 16, left: 8, bottom: 16, right: 8)
        collectionView.alwaysBounceVertical = true
        
        setupInfoView()
    }
    
    fileprivate func setupInfoView() {
        
        collectionView.addSubview(infoView)
        let sizeForEstimate = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: "emptySearchResultLabel".localized).boundingRect(with: sizeForEstimate, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], context: nil)
        
        infoView.anchor(top: collectionView.topAnchor, left: collectionView.leftAnchor, bottom: nil, right: collectionView.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: estimatedFrame.width + 16, height: estimatedFrame.height + 36)
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInfoTextView()
    }
    
    fileprivate func setupInfoTextView() {
        
        infoView.addSubview(infoTextView)
        infoTextView.text = "emptySearchResultLabel".localized
        infoTextView.anchor(top: infoView.topAnchor, left: infoView.leftAnchor, bottom: infoView.bottomAnchor, right: infoView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
}
