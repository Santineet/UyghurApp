//
//  DictionaryVC + fetchData.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation

extension DictionaryVC {
    
    func setupListeners() {
        
        setupDictinaryCategoriesListener()
    }
    
    fileprivate func setupDictinaryCategoriesListener() {
        
        self.dictionaryVM = DictionaryVM()
        self.dictionaryVM!.setupDictinaryCategoriesListener()
        self.dictionaryVM!.dictCategoryBR.skip(1).subscribe(onNext: { (eventType, dictionaryCategory) in
            switch eventType {
            case .Added:
                if let index = self.dictionaryCategories.firstIndex(where: { (item) -> Bool in
                    return item.id == dictionaryCategory.id
                }){
                    self.dictionaryCategories[index] = dictionaryCategory
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                } else {
                    self.dictionaryCategories.append(dictionaryCategory)
                    self.tableView.insertRows(at: [IndexPath(row: self.dictionaryCategories.count - 1, section: 0)], with: .bottom)
                }
                break
            case .Changed:
                if let index = self.dictionaryCategories.firstIndex(where: { (item) -> Bool in
                    return item.id == dictionaryCategory.id
                }){
                    self.dictionaryCategories[index] = dictionaryCategory
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                break
            case .Removed:
                if let index = self.dictionaryCategories.firstIndex(where: { (item) -> Bool in
                    return item.id == dictionaryCategory.id
                }){
                    self.dictionaryCategories.remove(at: index)
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                break
            }
        }).disposed(by: dispose)
    }
}
