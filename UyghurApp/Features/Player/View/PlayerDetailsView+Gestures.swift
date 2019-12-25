//
//  PlayerDetailsView+Gestures.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/8/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension PlayerDetailsView {

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
          if gesture.state == .changed {
              handlePanChanged(gesture: gesture)
          } else if gesture.state == .ended {
              handlePanEnded(gesture: gesture)
          }
    }
    
    func handlePanChanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        self.miniPlayerView.alpha = 1 + translation.y / 200
        self.episodeImageView.alpha = -translation.y / 200
    }
    
    func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        print("Ended:", velocity.y)
        
        if velocity.y > 500 {
            let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
            mainTabBarController?.playerDetailsView.player.pause()
            mainTabBarController?.playerDetailsView.isHidden = true
            homeDelegate?.changePlayingTrack(type: .Pause)
            audiosDelegate?.changePlayingTrack(type: .Pause)
            multimediaDelegate?.changePlayingTrack(type: .Pause)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            if translation.y < -200 || velocity.y < -500 {
                UIApplication.mainTabBarController()?.maximizePlayerDetails(song: nil, playlistSongs: self.playlistSongs ?? [])
            } else {
                self.miniPlayerView.alpha = 1
                self.episodeImageView.alpha = 0
            }
        })
    }
    
    @objc func handleTapMaximize() {
        UIApplication.mainTabBarController()?.maximizePlayerDetails(song: nil, playlistSongs: self.playlistSongs ?? [])
    }
    
}
