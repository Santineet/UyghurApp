//
//  MoreVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class MoreVC: UITableViewController {
    
    @IBOutlet weak var dictionaryLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var multimadiaLabel: UILabel!
    @IBOutlet weak var aboutUs: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setValueToLocalizedLabels()
    }
    
}
