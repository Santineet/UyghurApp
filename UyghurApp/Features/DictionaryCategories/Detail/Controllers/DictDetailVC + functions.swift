//
//  DictDetailVC + functions.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

extension DictDetailVC {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                guard !(seconds.isNaN || seconds.isInfinite) else {
                    return
                }
                
                self.hmsFrom(second: Int(seconds), completion: { (hours, minutes, second) in
                    let hours = self.getStringFrom(seconds: hours)
                    let minutes = self.getStringFrom(seconds: minutes)
                    let second = self.getStringFrom(seconds: second)
                    
                    self.andDuration.text = "\(hours):\(minutes):\(second)"
                    self.durationSlider.isEnabled = true
                    self.andDurationActivity.stopAnimating()
                })
            }
            
        }
    }
    
    func hmsFrom(second: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
        completion(second / 3600, (second % 3600) / 60, (second % 3600) % 60)
    }
    
    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    func deletePlayer() {
        
        self.player?.pause()
        self.player = nil
    }
}
