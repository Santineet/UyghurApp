//
//  Protocols.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/8/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import Foundation

enum TypeOfChange {
    case Next
    case Previous
    case Pause
    case Play
    case NewPlaylist
    case PlayFromTheEnd
}


protocol ChangePlayingTrackDelegate {
    func changePlayingTrack(type: TypeOfChange)
}

class HidePlayer {
    
    static let instance = HidePlayer()

    func hide(){
        let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.playerDetailsView.player.pause()
        mainTabBarController?.playerDetailsView.delegate?.changePlayingTrack(type: .Pause)
        
        mainTabBarController?.playerDetailsView.isHidden = true
    }
}
