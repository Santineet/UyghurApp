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
    @IBOutlet weak var allProductsLabel: UILabel!
    
    public var products = [StoreModel]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var link: HomeVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedAllProductsLabel))
        self.allProductsLabel.isUserInteractionEnabled = true
        self.allProductsLabel.addGestureRecognizer(tap)
    }
    
    
    //MARK: - setup CollectionView
    private func setupCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func didTappedAllProductsLabel() {
        
        self.link?.didTappedAllProductsLabel()
    }
    
}

extension ProductsTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - CollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    //MARK: - CollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCVCell", for: indexPath) as! ProductsCVCell
        
        let product = self.products[indexPath.row]
        if let urlString = product.image_urls.first?.image_url {
            cell.imageProduct.sd_setImage(with: URL(string: urlString), placeholderImage: nil)
        }
        cell.price.text = product.price
        cell.productName.text = product.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = self.products[indexPath.row]
        self.link?.didTappedProduct(product: product)
    }
    
}

extension ProductsTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 155, height: 300)
    }
    
}
