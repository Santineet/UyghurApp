//
//  TranslationVC + search.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension TranslationVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText:String) {
        
        filteredTranslations = self.translations.filter({ (translation:Translation) -> Bool in
            return translation.russian_word.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()
    }
    
}
