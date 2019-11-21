//
//  ProductsTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class ProductsTVCell: UITableViewCell {
    
    @IBOutlet weak var productsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        
    }
    
    //MARK: - setup CollectionView
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
 
    @IBAction func allProducts(_ sender: UIButton) {
   
    }
    
    
    
    
}

extension ProductsTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - CollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //MARK: - CollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCVCell", for: indexPath) as! ProductsCVCell
        
        return cell
        
    }
    
    
    
    
}

extension ProductsTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 155, height: 190)
        
    }
}
