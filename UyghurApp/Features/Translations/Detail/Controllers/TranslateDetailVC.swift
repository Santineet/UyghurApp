//
//  TranslateDetailVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class TranslateDetailVC: UITableViewController {

    @IBOutlet weak var russionWord: UILabel!
    @IBOutlet weak var cyrillicFormat: UILabel!
    @IBOutlet weak var latinFormat: UILabel!
    @IBOutlet weak var arabicFormat: UILabel!
    
    var translation: Translation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let translation = self.translation else { return }
        
        self.russionWord.text = translation.russian_word
        self.cyrillicFormat.text = "1    \(translation.cyrillic_word)"
        self.latinFormat.text = "2    \(translation.latin_word)"
        self.arabicFormat.text = "3    \(translation.arab_word)"
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "infoNavTitle".localized
    }
}
