//
//  StoreVC + collectionView.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreVC: UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getStoriesCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storeVCCell, for: indexPath) as! StoreCell
        var store: Store
        if isFiltering {
            store = self.filteredStories[indexPath.row]
        } else { store =  self.stories[indexPath.item] }
        cell.store = store
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var store: Store
        if isFiltering {
            store = self.filteredStories[indexPath.row]
        } else { store =  self.stories[indexPath.item] }
        
        presentToStoreDetailVC(store)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width-18)/2
        let store = self.stories[indexPath.item]
        if store.images[0].image_url != "" {
            if Int(store.images[0].height) >= (Int(self.view.frame.height/3)) {
                return CGSize(width: width, height: self.view.frame.height/3)
            } else { return CGSize(width: width, height: CGFloat.init(Float(store.images[0].height))) }
        }
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
