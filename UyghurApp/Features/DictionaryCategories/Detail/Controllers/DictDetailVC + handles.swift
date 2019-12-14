//
//  DictDetailVC + handles.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit

extension DictDetailVC {
    
    @IBAction func didTappedRewindButton(_ sender: Any) {
        
        guard player != nil else { return }
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        var newTime = playerCurrentTime - 8
        
        if newTime < 0 { newTime = 0 }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player!.seek(to: time2)
    }
    
    @IBAction func didTappedForwardButton(_ sender: Any) {
        
        guard player != nil else { return }
        guard let duration  = player?.currentItem!.duration else{ return }
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        let newTime = playerCurrentTime + 8
        
        if newTime < CMTimeGetSeconds(duration) {
            
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player!.seek(to: time2)
        }
    }
    
    @IBAction func didTappedPlayPauseButton(_ sender: Any) {
        
        guard player != nil else { return }
        if player?.rate == Float(0.0) {
            player?.play()
            UIView.animate(withDuration: 1) { self.playPauseButton.setImage(UIImage(named: "ic_pause"), for: .normal) }
        } else if player!.rate >= Float(0.1) {
            player?.pause()
            UIView.animate(withDuration: 1) { self.playPauseButton.setImage(UIImage(named: "ic_play"), for: .normal) }
        }
    }
    
    
    @IBAction func didChangedVolumeSlider(_ sender: UISlider) {
        player!.volume = sender.value
    }
    
    @IBAction func didChangeDurationSlider(_ sender: Any) {
        
        if let duration = player?.currentItem?.duration {
            
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(self.durationSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (complatedSeek) in
            })
        }
    }
}
