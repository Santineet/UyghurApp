//
//  DictDetailVC + setupUI.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

extension DictDetailVC {
    
    func setupUI(_ dictionaryCategory: DictionaryCategory) {
        
        setupPlayer(dictionaryCategory)
        setupAndDurationActivity()
        setupVolumeSlider()
        setupTableView()
        setupDurationSlider()
    }
    
    fileprivate func setupPlayer(_ dictionaryCategory: DictionaryCategory) {
        
        if dictionaryCategory.category_audio_url != "" {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                
                player = AVPlayer(url: URL.init(string: dictionaryCategory.category_audio_url)!)
                player!.automaticallyWaitsToMinimizeStalling = false
                player!.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
                
                let interval = CMTime(value: 1, timescale: 2)
                player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { (progressTime) in
                    let seconds = CMTimeGetSeconds(progressTime)
                    
                    self.hmsFrom(second: Int(seconds), completion: { (hours, minutes, second) in
                        let hours = self.getStringFrom(seconds: hours)
                        let minutes = self.getStringFrom(seconds: minutes)
                        let second = self.getStringFrom(seconds: second)
                        
                        self.presentDuration.text = "\(hours):\(minutes):\(second)"
                        
                        if let duration = self.player?.currentItem?.duration {
                            let durationSeconds = CMTimeGetSeconds(duration)
                            self.durationSlider.value = Float(seconds / durationSeconds)
                        }
                    })
                })
            } catch {}
        }
    }
    
    fileprivate func setupAndDurationActivity() {
        
        self.andDurationActivity.isHidden = false
        self.andDurationActivity.hidesWhenStopped = true
        self.andDurationActivity.startAnimating()
    }
    
    fileprivate func setupVolumeSlider() {
        
        print(AVAudioSession.sharedInstance().outputVolume)
        self.volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
    }
    
    fileprivate func setupTableView() {
        
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupDurationSlider() {
        
        durationSlider.setThumbImage(#imageLiteral(resourceName: "ic_oval"), for: .normal)
        durationSlider.isEnabled = false
    }
}
