//
//  StoreCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/23/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class StoreCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var store: Store? {
        didSet {
            if store!.images.count > 0 {
                productImage.sd_setImage(with: URL(string: store!.images[0].image_url))
            }
            
            productName!.text = store!.product_name
            productPrice!.text = store!.product_price
        }
    }
    
    override func awakeFromNib() {
        
        productImage.layer.cornerRadius = 8
        productImage.layer.masksToBounds = true
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
}
