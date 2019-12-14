//
//  StoreVC + fetchData.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreVC {
    
    func setupListeners() {
        
        setupStoreListener()
    }
    
    fileprivate func setupStoreListener() {
        
        self.storeVM = StoreVM()
        self.storeVM?.setupStoreListener()
        self.storeVM!.storeBR.skip(1).subscribe(onNext: { (eventType, store) in
            switch eventType {
            case .Added:
                if let index = self.stories.firstIndex(where: { (item) -> Bool in
                    return item.id == store.id
                }){
                    self.stories[index] = store
                    self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                } else {
                    self.stories.append(store)
                    self.collectionView.reloadData()
                }
                break
            case .Changed:
                if let index = self.stories.firstIndex(where: { (item) -> Bool in
                    return item.id == store.id
                }){
                    self.stories[index] = store
                    self.collectionView.reloadData()
                }
                break
            case .Removed:
                if let index = self.stories.firstIndex(where: { (item) -> Bool in
                    return item.id == store.id
                }){
                    self.stories.remove(at: index)
                    self.collectionView.reloadData()
                }
                break
            }
        }).disposed(by: dispose)
    }
}
