//
//  SongPlayerVC.swift
//  UyghurApp
//
//  Created by Mairambek on 12/5/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVFoundation

class SongPlayerVC: UIViewController {

    
    //MARK: IB Outlets
    @IBOutlet weak var playPlayerButton: UIButton!
    @IBOutlet weak var nextPlayerButton: UIButton!
    @IBOutlet weak var previousPlayerButton: UIButton!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var nameSongLabel: UILabel!
    @IBOutlet weak var volumSlider: UISlider!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTextView: UITextView!
    
    @IBOutlet weak var presentDuration: UILabel!
    @IBOutlet weak var andDuration: UILabel!
    @IBOutlet weak var activityIndicat: UIActivityIndicatorView!

    
    public var audios = [AudiosModel]()

    //MARK: Player Variables
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var playing: Bool = false
    var index: Int = 0
    var playlistEnd: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOutlets()
        setupTargets()
    }

   func  setupOutlets(){

    let audio = audios[index]

    self.songTextView.text = audio.text_kiril
    self.songTextView.isEditable = false
    self.nameSongLabel.text = audio.name
    self.singerLabel.text = audio.artist_name
    self.songImage.sd_setImage(with: URL(string: audio.image_url), placeholderImage: nil)
    self.volumSlider.minimumValue = 0
    self.volumSlider.maximumValue = 1

    }
    
    @IBAction func volumSliderAction(_ sender: UISlider) {
        
        let selectedValue = Float(sender.value)
        player?.volume = selectedValue
    }
    
    @IBAction func didChangeDurationSlider(_ sender: UISlider) {
        if let duration = player?.currentItem?.duration {
                
                let totalSeconds = CMTimeGetSeconds(duration)
                let value = Float64(self.durationSlider.value)  //* totalSeconds
                let seekTime = CMTime(value: Int64(value), timescale: 1)
                player?.seek(to: seekTime, completionHandler: { (complatedSeek) in
                })
            
            }
        
    }
    //    @objc func changeVolumObserver(sender: UISlider){
//
//        player?.volume = sender.value
//
//    }
//
    func setupTargets(){
       
        self.playPlayerButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        self.nextPlayerButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        self.previousPlayerButton.addTarget(self, action: #selector(previousButtonPressed), for: .touchUpInside)
//        guard let url = URL(string: audios[index].audio_url) else { return }
               
        guard let url = URL(string:"https://s3.amazonaws.com/kargopolov/kukushka.mp3") else { return }

        
        self.play(url: url)
        
    }
    
      
    private func play(url: URL){

        self.playPlayerButton.isHidden = true
        self.activityIndicat.isHidden = false
        self.activityIndicat.startAnimating()
        
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem:playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector( playerDidFinishPlaying(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector( ItemFailedToPlayToEndTime(note:)), name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: playerItem)
        
          NotificationCenter.default.addObserver(self, selector: #selector( ItemNewErrorLogEntry(note:)), name: NSNotification.Name.AVPlayerItemNewErrorLogEntry, object: playerItem)
       
        NotificationCenter.default.addObserver(self, selector: #selector( ItemNewAccessLogEntry(note:)), name: NSNotification.Name.AVPlayerItemNewAccessLogEntry, object: playerItem)
        
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            
        }

   
        player!.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { (progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            
            self.hmsFrom(second: Int(seconds), completion: { (hours, minutes, second) in

                let minutes = self.getStringFrom(seconds: minutes)
                let second = self.getStringFrom(seconds: second)
                self.presentDuration.text = "\(minutes):\(second)"
                
                if let duration = self.player?.currentItem?.duration {
                    print("self.player?.currentItem?.duratio")
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.durationSlider.value = Float(seconds)
                }
            })
        })
        
        
        
        
//        player!.volume = 1.0
        self.playing = true
        player!.play()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                guard !(seconds.isNaN || seconds.isInfinite) else {
                    return
                }
                
                self.hmsFrom(second: Int(seconds), completion: { (hours, minutes, second) in
//                    let hours = self.getStringFrom(seconds: hours)
                    let minutes = self.getStringFrom(seconds: minutes)
                    let second = self.getStringFrom(seconds: second)
                    
                    self.andDuration.text = "\(minutes):\(second)"
                    self.durationSlider.isEnabled = true
                    self.activityIndicat.stopAnimating()
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
    
    
    @objc func playButtonPressed() {
        if playlistEnd == true {
            guard let url = URL(string: audios[index].audio_url) else { return }
            setupOutlets()
            play(url: url)
        } else if playing == true {
            self.playing = false
            player?.pause()
        } else {
            self.playing = true
            player?.play()
        }
    }
    
    @objc func nextButtonPressed() {
   
        index += 1
            
        if index < self.audios.count{

            setupOutlets()
            guard let url = URL(string: audios[index].audio_url) else { return }
            self.play(url: url)
        } else {
            self.playing = false
            self.playlistEnd = true
            index = 0
            setupOutlets()
            player?.pause()
            self.playPlayerButton.setImage(UIImage(named: "PlayerPlay"), for: .normal)
            player = nil
        }
    
    }
    
    @objc func previousButtonPressed() {
        print("index \(index)")
        index -= 1
        if index >= 0 {
            guard let url = URL(string: audios[index].audio_url) else { return }
            setupOutlets()
            self.play(url: url)
        } else {
            print("paused")
            self.playing = false
            self.playlistEnd = true
            index = 0
            player?.pause()
            self.playPlayerButton.setImage(UIImage(named: "PlayerPlay"), for: .normal)
            player = nil
        }
        
         
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {

//        index += 1
//        guard let url = URL(string:  audios[index].audio_url) else { return }
//        play(url: url)
    }
    
    @objc func ItemFailedToPlayToEndTime(note: NSNotification) {
        print("call ItemFailedToPlayToEndTime ")

      }
    
    @objc func ItemNewErrorLogEntry(note: NSNotification) {

        self.activityIndicat.stopAnimating()
        self.activityIndicat.isHidden = true
        self.playPlayerButton.isHidden = false
        self.playlistEnd = true
        self.playPlayerButton.setImage(UIImage(named: "PlayerPlay"), for: .normal)
        Alert.displayAlert(title: "", message: "Произошла ошибка, попробуйте позже", vc: self)
    }
    
    @objc func ItemNewAccessLogEntry(note: NSNotification) {
        self.playlistEnd = false
        self.playPlayerButton.isHidden = false
        if playing {
            self.playPlayerButton.setImage(UIImage(named: "PausePlayer"), for: .normal)
        } else {
            self.playPlayerButton.setImage(UIImage(named: "PlayerPlay"), for: .normal)
        }

        
        if let duration = self.player?.currentItem?.duration {

            let durationSeconds = CMTimeGetSeconds(duration)
            self.durationSlider.maximumValue = Float(durationSeconds)
        }

        self.activityIndicat.isHidden = true
        self.activityIndicat.stopAnimating()
    }
    
    
    
    
    
    
    
    
    
    func setupRemoteTransportControls() {
//        // Get the shared MPRemoteCommandCenter
//        let commandCenter = 
//        // Add handler for Pause Command
//        commandCenter.pauseCommand.addTarget { [unowned self] event in
//            if self.player.rate == 1.0 {
//                self.player.pause()
//                return .success
//            }
//            return .commandFailed
//        }
    }
    
    
    
    
}
           
   


