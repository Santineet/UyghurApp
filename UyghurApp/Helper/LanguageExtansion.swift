//
//  LanguageExtansion.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

var bundleAssociatedObject = "bundlePath"

class PrivateBundle: Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        
        guard let bundlePath = objc_getAssociatedObject(self, &bundleAssociatedObject) as? String else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        guard let bundle = Bundle(path: bundlePath) else{
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    func setAppLanguage(language: String) {
        
        UserDefaults.standard.set(language, forKey: Constants.applicationCurrentLanguage)
        object_setClass(Bundle.main, PrivateBundle.self)
        
        objc_setAssociatedObject(Bundle.main, &bundleAssociatedObject ,Bundle.main.path(forResource: language, ofType: "lproj"),.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func getAppLanguage() -> String? {
        return Bundle.main.preferredLocalizations.first
    }
    
    func getVersion() -> String {
        return "\("app_version".localized) - \(releaseVersionNumber!)(\(buildVersionNumber!))"
    }
}
