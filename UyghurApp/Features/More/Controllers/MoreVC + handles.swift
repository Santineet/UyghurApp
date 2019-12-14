//
//  MoreVC + handles.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension MoreVC {
    
    @IBAction func didTappedSettingButton(_ sender: Any) {
        
        let settingAlertController = UIAlertController(title: "settingsAlertTitle".localized, message: "settingsAlertMessage".localized, preferredStyle: .actionSheet)
        
        settingAlertController.addAction(UIAlertAction(title: "languageAction".localized, style: .default, handler: { (_) in
            
            self.setupLanguageAlert()
        }))
        
        settingAlertController.addAction(UIAlertAction(title: "cancelAction".localized, style: .cancel, handler: nil))
        
        present(settingAlertController, animated: true, completion: nil)
    }  
}
