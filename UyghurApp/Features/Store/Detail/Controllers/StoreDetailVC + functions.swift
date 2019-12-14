//
//  StoreDetailVC + functions.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import PKHUD

extension StoreDetailVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / collectionView.frame.width
        pageController.currentPage = Int(scrollPos)
    }
    
    func setValueToLocalizedLabels() {
        
        navigationItem.title = "infoNavTitle".localized
    }
    
    func setValueToLabels(_ store: Store) {
        
        if store.images.count > 1 {
            self.pageController.isHidden = false
            self.pageController.numberOfPages = (store.images.count)
        } else {
            self.pageController.isHidden = true
            self.pageController.numberOfPages = 0
        }
        
        self.productName.text = store.product_name
        self.productPrice.text = store.product_price
        self.productDescription.text = store.product_description
    }
    
    func openWhatsapp(number: String) {
        
        let urlWhats = "whatsapp://send?phone=\(number)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                } else {
                    PKHUD.sharedHUD.contentView = PKHUDErrorView(title: "installAppMessage".localized + " Whatsapp", subtitle: "youCnstallAppMessage".localized)
                    PKHUD.sharedHUD.show()
                    PKHUD.sharedHUD.hide(afterDelay: 2.0);
                }
            }
        }
    }
    
    func openTelegramm(number: String) {
        let urlWhats = "https://telegram.me/\(self.telegramUrl)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else { UIApplication.shared.openURL(whatsappURL) }
                } else {
                    PKHUD.sharedHUD.contentView = PKHUDErrorView(title: "installAppMessage".localized + " Telegramm", subtitle: "youCnstallAppMessage".localized)
                    PKHUD.sharedHUD.show()
                    PKHUD.sharedHUD.hide(afterDelay: 2.0);
                }
            }
        }
    }
    
    func openCall(number: String) {
        if let url = URL(string: "tel://\(number)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                PKHUD.sharedHUD.contentView = PKHUDErrorView(title: "failedToCall".localized + " \(number)", subtitle: "")
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 2.0);
            }
        } else {
            PKHUD.sharedHUD.contentView = PKHUDErrorView(title: "failedToCall".localized + " \(number)", subtitle: "")
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 2.0);
        }
    }
    
}
