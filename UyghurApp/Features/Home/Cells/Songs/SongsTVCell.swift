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
        
        return 2
    }
    
    //MARK: - CollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongsCVCell", for: indexPath) as! SongsCVCell
        
        return cell
    }
    
}

extension SongsTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }

        
}

