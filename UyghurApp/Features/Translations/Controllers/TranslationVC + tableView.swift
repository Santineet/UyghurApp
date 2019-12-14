//
//  TranslationVC + tableView.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension TranslationVC {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTranslationsCount()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: wordCellID, for: indexPath) as! WordCell
        var translation: Translation
        
        if isFiltering {
            translation = self.filteredTranslations[indexPath.row]
        } else { translation =  self.translations[indexPath.item] }
        cell.translation = translation
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var translation: Translation
        
        if isFiltering {
            translation = self.filteredTranslations[indexPath.row]
        } else { translation =  self.translations[indexPath.item] }
        
        presentToTranslationDetailVC(translation)
    }
    
}
