//
//  TranslationVC + functions.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension TranslationVC {
    
    func getTranslationsCount() -> Int {
        
        if self.translations.count == 0 {
            self.setInfoViewHidden(isHidden: false)
            return 0
        }
        if isFiltering {
            if self.filteredTranslations.count == 0 {
                self.setInfoViewHidden(isHidden: false)
                return 0
            }
        }
        
        self.setInfoViewHidden(isHidden: true)
        return isFiltering ? filteredTranslations.count : translations.count
    }
    
    func setInfoViewHidden(isHidden: Bool) {
        infoView.isHidden = isHidden
        infoTextView.isHidden = isHidden
    }
    
    func presentToTranslationDetailVC(_ translation: Translation) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TranslateDetailVC") as? TranslateDetailVC {
            
            if let navigator = navigationController {
                viewController.translation = translation
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func setValueToLocalizedLabels() {
        
        navigationItem.title = "translateNavTitle".localized
        searchController.searchBar.placeholder = "searchPlaceholder".localized
    }
}
