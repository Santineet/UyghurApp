//
//  StoreDetailVC + handles.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension StoreDetailVC {
    
    @IBAction func didTappedWhatsappButton(_ sender: UIButton) {
        sender.pulsate(sender: sender)
        if self.phoneNumber != "" {
            self.openWhatsapp(number: self.phoneNumber)
        } else {}
    }
    
    @IBAction func didTappedTelegrammButton(_ sender: UIButton) {
        sender.pulsate(sender: sender)
        if self.phoneNumber != "" {
            self.openTelegramm(number: self.telegramUrl)
        } else {}
    }
    
    @IBAction func didTappedPhoneButton(_ sender: UIButton) {
        sender.pulsate(sender: sender)
        if self.phoneNumber != "" {
            self.openCall(number: self.phoneNumber)
        } else {}
    }
}
