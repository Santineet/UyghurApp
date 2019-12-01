//
//  Alert.swift
//  UyghurApp
//
//  Created by Mairambek on 11/26/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

struct Alert {
    static func displayAlert(title: String, message: String, vc: UIViewController)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}
