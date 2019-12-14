//
//  StoreVC + functions.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreVC {
    
    func getStoriesCount() -> Int {
         
         if self.stories.count == 0 {
             self.setInfoViewHidden(isHidden: false)
             return 0
         }
         if isFiltering {
             if self.filteredStories.count == 0 {
                 self.setInfoViewHidden(isHidden: false)
                 return 0
             }
         }
         self.setInfoViewHidden(isHidden: true)
         return isFiltering ? filteredStories.count : self.stories.count
     }
     
     func setInfoViewHidden(isHidden: Bool) {
         infoView.isHidden = isHidden
         infoTextView.isHidden = isHidden
     }
    
    func setValueLocalizedLabels() {
        
        navigationItem.title = "storeNavTitle".localized
        searchController.searchBar.placeholder = "searchPlaceholder".localized
    }
    
    func presentToStoreDetailVC(_ store: Store) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreDetailVC") as? StoreDetailVC {
            if let navigator = navigationController {
                viewController.store = store
                navigator.pushViewController(viewController, animated: true) }
        }
    }
}
