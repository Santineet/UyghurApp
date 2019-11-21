//
//  DictionaryTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class DictionaryTVCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupCollectionView()
        
    }

    //MARK: - setup CollectionView
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func allButton(_ sender: UIButton) {
  
    }
    
}


//MARK: -  UICollectionView Delegate
extension DictionaryTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: -  UICollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    //MARK: -  UICollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DictionaryCVCell", for: indexPath) as! DictionaryCVCell
    
        return cell
    }
    
    
}

extension DictionaryTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: -  UICollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath:IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
}
