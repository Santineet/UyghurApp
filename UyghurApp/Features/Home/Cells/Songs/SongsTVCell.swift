//
//  SongsTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class SongsTVCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var audios = [AudiosModel]()

    override func awakeFromNib() {
        super.awakeFromNib()

        setupCollectionView()
    }


    
    //MARK: - setup CollectionView
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func allSongsButton(_ sender: UIButton) {
    }
    
    

}

extension SongsTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - CollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.audios.count <= 3 {
            return 1
        } else if self.audios.count % 3 == 0 {
            return self.audios.count  % 3
        } else {
             return self.audios.count  % 3 + 1
        }
        
    }
    
    //MARK: - CollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongsCVCell", for: indexPath) as! SongsCVCell
        cell.audios = audios
        cell.index = indexPath.row
        
        cell.tableView.reloadData()
        
        return cell
    }
    
}

extension SongsTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

        
}

