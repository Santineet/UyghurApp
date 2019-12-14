//
//  DictDetailVC + fetchData.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension DictDetailVC {
    
    func setupListeners(_ dictionaryCategory: DictionaryCategory) {
        
        setupDictinariesListener(category_name: dictionaryCategory.category_name)
    }
    
    fileprivate func setupDictinariesListener(category_name: String) {
        
        self.dictionaryVM = DictionaryVM()
        self.dictionaryVM?.setupDictinaryWordsListener(category_name: category_name)
        self.dictionaryVM!.dictWordBR.skip(1).subscribe(onNext: { (eventType, dictionary_word) in
            switch eventType {
            case .Added:
                if let index = self.dictionary_words.firstIndex(where: { (item) -> Bool in
                    return item.id == dictionary_word.id
                }){
                    self.dictionary_words[index] = dictionary_word
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                } else {
                    self.dictionary_words.append(dictionary_word)
                    self.tableView.insertRows(at: [IndexPath(row: self.dictionary_words.count - 1, section: 0)], with: .bottom)
                }
                break
            case .Changed:
                if let index = self.dictionary_words.firstIndex(where: { (item) -> Bool in
                    return item.id == dictionary_word.id
                }){
                    self.dictionary_words[index] = dictionary_word
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                break
            case .Removed:
                if let index = self.dictionary_words.firstIndex(where: { (item) -> Bool in
                    return item.id == dictionary_word.id
                }){
                    self.dictionary_words.remove(at: index)
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                break
            }
        }).disposed(by: dispose)
    }
}
