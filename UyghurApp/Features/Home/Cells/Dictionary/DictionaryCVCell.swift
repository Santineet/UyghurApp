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
    
    override func awakeFromNib() {
          super.awakeFromNib()

        tableView.alwaysBounceVertical = false
    }
    
    
}

//MARK: - UITableView Delegate
extension DictionaryCVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //MARK: - UITableView cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VerbsTVCell", for: indexPath) as! VerbsTVCell
        
        cell.name.text = "name \(indexPath.row)"
        return cell
    }
    
    //MARK: - UITableView heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    
}
