//
//  DictionaryVC + tableView.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

// MARK: - Table view data source

extension DictionaryVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dictionaryCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dictCellID, for: indexPath) as! DictCell
        
        let dictCategory = self.dictionaryCategories[indexPath.item]
        cell.dictCategoryLabel.text = dictCategory.category_name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DictDetailVC") as? DictDetailVC {
            HidePlayer.instance.hide()

            if let navigator = navigationController {
                let dictCategory = self.dictionaryCategories[indexPath.item]
                viewController.dictionaryCategory = dictCategory
                navigator.pushViewController(viewController, animated: true) }
        }
    }
}
