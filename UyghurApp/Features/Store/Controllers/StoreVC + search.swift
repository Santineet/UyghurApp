//
//  StoreVC + search.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText:String) {
        
        filteredStories = self.stories.filter({ (store:Store) -> Bool in
            return store.product_name.lowercased().contains(searchText.lowercased())
        })
        self.collectionView.reloadData()
    }
    
}
