//
//  MainTabBarVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/6/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        UINavigationBar.appearance().prefersLargeTitles = true

        setupPlayerDetailsView()
    }
    
    
    @objc func minimizePlayerDetails() {
        tabBar.isHidden = false
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
           
            self.tabBar.transform = .identity
            self.view.layoutIfNeeded()
            self.playerDetailsView.dismissButton.isHidden = true 
            self.playerDetailsView.episodeImageView.alpha = 0
            self.playerDetailsView.imageForBackground.alpha = 0
            self.playerDetailsView.songTextView.alpha = 0
            self.playerDetailsView.miniPlayerView.alpha = 1
        })
    }

    
    func maximizePlayerDetails(song: Audio?, playlistSongs: [Audio] = []) {
        tabBar.isHidden = true
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        if song != nil {
            playerDetailsView.song = song
        }
        playerDetailsView.playlistSongs = playlistSongs
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
              
              self.view.layoutIfNeeded()
              
              self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
              
            self.playerDetailsView.episodeImageView.alpha = 1
            self.playerDetailsView.episodeImageView.alpha = 1
            self.playerDetailsView.dismissButton.isHidden = false
            self.playerDetailsView.imageForBackground.alpha = 0.7
            self.playerDetailsView.songTextView.alpha = 1
            self.playerDetailsView.miniPlayerView.alpha = 0
              
          })
        
    }
    //MARK:- Setup Functions
    let playerDetailsView = PlayerDetailsView.initFromNib()
    
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!
    
    fileprivate func setupPlayerDetailsView() {
        print("Setting up PlayerDetailsView")
        view.insertSubview(playerDetailsView, belowSubview: tabBar)
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        maximizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizedTopAnchorConstraint.isActive = true
        bottomAnchorConstraint = playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraint.isActive = true
        minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        print(tabBar.frame.height)
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }

}
