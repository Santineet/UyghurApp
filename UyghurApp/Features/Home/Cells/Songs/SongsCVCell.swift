//
//  SongsCVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class SongsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupTableView()
        
    }
    
    
    //MARK: - setup TableView
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SongsCVCell: UITableViewDelegate, UITableViewDataSource {
  
    //MARK: - setup numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //MARK: - setup cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongDetailTVCell", for: indexPath) as! SongDetailTVCell
        
        return cell
    }
    
    //MARK: - setup heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 54
    }
    
    
    
}
