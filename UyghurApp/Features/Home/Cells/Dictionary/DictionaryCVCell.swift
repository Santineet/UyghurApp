//
//  DictionaryCVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class DictionaryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    
    public var categories = [DictionaryCategoriesModel]()
    public var index = 0
    
    var link: DictionaryTVCell?
    
    override func awakeFromNib() {
          super.awakeFromNib()
        
        setupTableView()
    }
    
    private func setupTableView(){
        
        tableView.alwaysBounceVertical = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

//MARK: - UITableView Delegate
extension DictionaryCVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

         let objectsCount = self.categories.count - 3 * index
         if objectsCount == 0 {
             return 0
         } else if objectsCount == 1 {
             return 1
         } else if objectsCount == 2 {
             return 2
         }
         return 3
    }
    
    //MARK: - UITableView cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row + self.index * 3
        let category = self.categories[index]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VerbsTVCell", for: indexPath) as! VerbsTVCell
        cell.name.text = category.category_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = self.categories[indexPath.row]
        HidePlayer.instance.hide()
        self.link?.didTappedDictionary(category: category)
    }
    
    //MARK: - UITableView heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}
