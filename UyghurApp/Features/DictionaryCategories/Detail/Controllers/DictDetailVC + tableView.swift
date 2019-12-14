//
//  DictDetailVC + tableView.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension DictDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dictionary_words.count == 0 { return 0 }
        return self.dictionary_words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dictCellID, for: indexPath) as! DictDetailCell
        let dictionary_word = self.dictionary_words[indexPath.item]
        cell.russianWord.text = dictionary_word.russian_word
        cell.uyghurWord.text = dictionary_word.uyghur_word
        return cell
    }
}
