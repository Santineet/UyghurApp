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
    
    public var products = [StoreModel]()
    
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
        return self.products.count
    }
    
    //MARK: - CollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = self.products[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCVCell", for: indexPath) as! ProductsCVCell
       
        if let urlString = product.image_urls.first?.image_url {
            cell.imageProduct.sd_setImage(with: URL(string: urlString), placeholderImage: nil)
        }
        cell.price.text = product.price
        cell.productName.text = product.name

        return cell
    }
    
    
}

extension ProductsTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 155, height: 190)
        
    }
}
