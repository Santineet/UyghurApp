//
//  HistoriesVC + search.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/4/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension HistoriesVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText:String) {
        
        filteredHistories = self.histories.filter({ (history:History) -> Bool in
            return history.history_title.lowercased().contains(searchText.lowercased())
        })
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
    
}
