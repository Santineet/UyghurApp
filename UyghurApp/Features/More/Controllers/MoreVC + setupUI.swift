
//
//  MoreVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension MoreVC {
    
    func setupUI() {
        
        setupTableViewStyle()
    }
    
    fileprivate func setupTableViewStyle() {
        
        tableView.tableFooterView = UIView()
    }
    
    func setupLanguageAlert() {
        
        let languageAlertController = UIAlertController(title: "languageAlertTitle".localized, message: "languageAlertMessage".localized, preferredStyle: .actionSheet)
        
        languageAlertController.addAction(UIAlertAction(title: "English", style: .default, handler: { (_) in
            Bundle.main.setAppLanguage(language: Constants.englishLanguage)
            self.viewWillAppear(true)
        }))
        
        languageAlertController.addAction(UIAlertAction(title: "Русский", style: .default, handler: { (_) in
            Bundle.main.setAppLanguage(language: Constants.russianLanguage)
            self.viewWillAppear(true)
        }))
        
        languageAlertController.addAction(UIAlertAction(title: "Уйгурча", style: .default, handler: { (_) in
            Bundle.main.setAppLanguage(language: Constants.uyghurLanguage)
            self.viewWillAppear(true)
        }))
        
        languageAlertController.addAction(UIAlertAction(title: "cancelAction".localized, style: .cancel, handler: nil))
        
        self.present(languageAlertController, animated: true, completion: nil)
    }
}

