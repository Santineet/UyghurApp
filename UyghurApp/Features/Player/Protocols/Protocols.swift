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
    case Stop
}


protocol ChangePlayingTrackDelegate {
    func changePlayingTrack(type: TypeOfChange)
}
