//
//  StoreDetailVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class StoreDetailVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    
    var store: Store?
    var phoneNumber: String = ""
    var telegramUrl: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        guard let store = self.store else { return }
        setupListeners()
        setValueToLabels(store)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setValueToLocalizedLabels()
    }
    
}
