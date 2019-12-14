//
//  DictionaryVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift

class TranslationVC: UITableViewController {
    
    let wordCellID = "wordCellID"
    
    var infoView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 0.12)
        view.layer.cornerRadius = 12
        return view
    }()
    
    var infoTextView: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    var translationVM: TranslationVM?
    let dispose = DisposeBag()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty:Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    var isFiltering:Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var filteredTranslations = [Translation]()
    var translations = [Translation]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupListeners()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        setValueToLocalizedLabels()
    }
    
}
