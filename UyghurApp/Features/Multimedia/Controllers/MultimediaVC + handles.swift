//
//  MultimediaVC + handles.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/4/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension MultimediaVC {
    
    @objc func didTappedAllVideosLabel() {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideosVC") as? VideosVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    @objc func didTappedAllAudiosLabel() {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudiosVC") as? AudiosVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true) }
        }
    }
}
