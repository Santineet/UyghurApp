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
    case NewPlaylist
    case PlayFromTheEnd
    case Play
}


protocol ChangeHomePlayerTrackDelegate {
    func changePlayingTrack(type: TypeOfChange)
}

protocol ChangeMultimediaPlayerTrackDelegate {
    func changePlayingTrack(type: TypeOfChange)
}

protocol ChangeAudiosPlayerTrackDelegate {
    func changePlayingTrack(type: TypeOfChange)
}

class HidePlayer {
    
    static let instance = HidePlayer()

    func hide(){
        let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.playerDetailsView.player.pause()
        mainTabBarController?.playerDetailsView.homeDelegate?.changePlayingTrack(type: .Pause) 
        mainTabBarController?.playerDetailsView.audiosDelegate?.changePlayingTrack(type: .Pause)
        mainTabBarController?.playerDetailsView.multimediaDelegate?.changePlayingTrack(type: .Pause)

        mainTabBarController?.playerDetailsView.isHidden = true
    }
}
