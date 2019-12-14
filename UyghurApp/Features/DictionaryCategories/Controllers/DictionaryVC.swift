//
//  DictionaryVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift
import AVKit

class DictionaryVC: UITableViewController {

    let dictCellID = "dictCellID"
    
    var dictionaryVM: DictionaryVM?
    let dispose = DisposeBag()
    
    var dictionaryCategories = [DictionaryCategory]() {
        didSet { DispatchQueue.main.async { self.tableView.reloadData() } }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupListeners()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "dictNavTitle".localized
    }
    
}
