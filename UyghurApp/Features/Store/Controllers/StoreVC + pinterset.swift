//
//  StoreVC + pinterset.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let store = self.stories[indexPath.item]
        if store.images.count > 0 {
            if Int(store.images[0].height) >= (Int(self.view.frame.height/3)) {
                return self.view.frame.height/3
            } else { return CGFloat.init(Float(store.images[0].height)) }
        }
        return self.view.frame.height/3
    }
}
