//
//  AboutVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/24/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "aboutUsNavTitle".localized
    }
    
}
