//
//  StoreDetailVC + fetchdata.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreDetailVC {
    
    func setupListeners() {
        
        getPhoneNumber()
    }
    
    fileprivate func getPhoneNumber() {
        
        FIRRefManager.instance.contactsRef.getDocuments { (querySnapshot, error) in
            guard error == nil else { return }
            
            querySnapshot?.documentChanges.forEach({ (documentChange) in
                let phoneNumber = documentChange.document.get("phoneNumber")
                self.phoneNumber = "\(phoneNumber!)"
                
                let telegramUrl = documentChange.document.get("telegramAccount")
                self.telegramUrl = "\(telegramUrl!)"
            })
        }
    }
}
