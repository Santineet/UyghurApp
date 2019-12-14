//
//  TranslationVC + fetchData.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension TranslationVC {
    
    func setupListeners() {
        setupTranslationsListener()
    }
    
    fileprivate func setupTranslationsListener() {
        
        self.translationVM = TranslationVM()
        self.translationVM?.setupTranslationsListener()
        self.translationVM?.translationBR.skip(1).subscribe(onNext: { (eventType, translation) in
            switch eventType {
            case .Added:
                if let index = self.translations.firstIndex(where: { (item) -> Bool in
                    return item.id == translation.id
                }){
                    self.translations[index] = translation
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                } else {
                    self.translations.append(translation)
                    self.tableView.insertRows(at: [IndexPath(row: self.translations.count - 1, section: 0)], with: .bottom)
                }
                break
            case .Changed:
                if let index = self.translations.firstIndex(where: { (item) -> Bool in
                    return item.id == translation.id
                }){
                    self.translations[index] = translation
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                break
            case .Removed:
                if let index = self.translations.firstIndex(where: { (item) -> Bool in
                    return item.id == translation.id
                }){
                    self.translations.remove(at: index)
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                break
            }
        }).disposed(by: dispose)
    }
}
