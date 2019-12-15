//
//  PlayerDetailsView.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/8/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class PlayerDetailsView: UIView {
    
    var delegate: ChangePlayingTrackDelegate?
    
    var song: Audio! {
        didSet {
            miniTitleLabel.text = song.audio_name
            titleLabel.text = song.audio_name
            authorLabel.text = song.artist_name
            
            let style = NSMutableParagraphStyle()
                   style.alignment = NSTextAlignment.center
            
            let attributed = NSMutableAttributedString(string: song.audio_text_kiril, attributes: [.font : UIFont.systemFont(ofSize: 13, weight: .light), .foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle: style])
            
            attributed.append(NSMutableAttributedString(string: "\n\n\(song.audio_text_latin)", attributes: [.font : UIFont.systemFont(ofSize: 13, weight: .light), .foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle: style]))
            
            attributed.append(NSMutableAttributedString(string: "\n\n\(song.audio_text_arab)", attributes: [.font : UIFont.systemFont(ofSize: 13, weight: .light), .foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle: style]))
            
            songTextView.attributedText = attributed
            
            setupNowPlayingInfo()
            setupAudioSession()
            playSong()
            
            guard let url = URL(string: song.audio_image_url) else { return }
            episodeImageView.sd_setImage(with: url)
            
            miniEpisodeImageView.sd_setImage(with: url) { (image, _, _, _) in
                var newImage: UIImage? = nil
                if image == nil {
                    newImage = UIImage(systemName: "music.note.list")
                } else { newImage = image }
                let artworkItem = MPMediaItemArtwork(boundsSize: .zero, requestHandler: { (size) -> UIImage in
                    return newImage!
                })
                MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPMediaItemPropertyArtwork] = artworkItem
            }
        }
    }
    
    //MARK: - Setup Player Methods
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    fileprivate func setupNowPlayingInfo() {
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = song.audio_name
        nowPlayingInfo[MPMediaItemPropertyArtist] = song.artist_name
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    fileprivate func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let sessionErr {
            print("Failed to activate session:", sessionErr)
        }
    }
    
    //MARK: - observe Player CurrentTime
    fileprivate func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            self?.currentTimeLabel.text = time.toDisplayString()
            let durationTime = self?.player.currentItem?.duration
            self?.durationLabel.text = durationTime?.toDisplayString()
            
            self?.updateCurrentTimeSlider()
        }
    }
    
    
    fileprivate func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        self.currentTimeSlider.value = Float(percentage)
    }
    
    var panGesture: UIPanGestureRecognizer!
    
    //MARK: - Gestures Methods
    fileprivate func setupGestures() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapMaximize)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        miniPlayerView.addGestureRecognizer(panGesture)
        dismissButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismissalPan)))
    }
    
    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer) {
        print("maximized dismissal")
        if gesture.state == .changed {
            let translation = gesture.translation(in: superview)
            
            self.dismissButton.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.episodeImageView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.authorLabel.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.currentTimeSlider.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.imageForBackground.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.songTextView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.durationLabel.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.currentTimeLabel.transform = CGAffineTransform(translationX: 0, y: translation.y)

        } else if gesture.state == .ended {
            let translation = gesture.translation(in: superview)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.episodeImageView.transform = .identity
                self.authorLabel.transform = .identity
                self.currentTimeSlider.transform = .identity
                self.titleLabel.transform = .identity
                self.imageForBackground.transform = .identity
                self.durationLabel.transform = .identity
                self.currentTimeLabel.transform = .identity
                self.songTextView.transform = .identity
                self.dismissButton.transform = .identity
                
                if translation.y > 50 {
                    let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
                    mainTabBarController?.minimizePlayerDetails()
                }
            })
        }
    }
    
    fileprivate func setupRemoteControl() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.player.rate == 0.0 {
                self.player.play()
                self.delegate?.changePlayingTrack(type: .Play)
                let pauseImage = UIImage(systemName: "pause.fill")
                self.playPauseButton.setImage(#imageLiteral(resourceName: "ic_pause"), for: .normal)
                self.miniPlayPauseButton.setImage(pauseImage, for: .normal)
                self.setupElapsedTime(playbackRate: 1)

                return .success
            }
            return .commandFailed
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.player.rate == 1.0 {
                self.player.pause()
                self.delegate?.changePlayingTrack(type: .Pause)
                let playImage = UIImage(systemName: "play.fill")
                self.playPauseButton.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
                self.miniPlayPauseButton.setImage(playImage, for: .normal)
                self.setupElapsedTime(playbackRate: 0)
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.nextTrackCommand.addTarget { [unowned self]     event in
            print("Next")
            self.handleNextTrack()
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { [unowned self]     event in
            print("Previous")
            self.handlePrevTrack()
            return .success
        }
        
        
    }
    
    fileprivate func setupElapsedTime(playbackRate: Float) {
        let elapsedTime = CMTimeGetSeconds(player.currentTime())
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = elapsedTime
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyPlaybackRate] = playbackRate
    }
    
    var playlistSongs: [Audio]?
    
    
    @objc fileprivate func handlePrevTrack() {
        
        
        guard let playlistSongs = self.playlistSongs  else { return }
        if playlistSongs.isEmpty {
            return
        }
        

        let currentEpisodeIndex = playlistSongs.firstIndex { (ep) -> Bool in
            return self.song.audio_name == ep.audio_name && self.song.artist_name == ep.artist_name
        }
        
        guard let index = currentEpisodeIndex else { return }
        let prevEpisode: Audio
        if index == 0 {
            let count = playlistSongs.count
            delegate?.changePlayingTrack(type: .PlayFromTheEnd)
            prevEpisode = playlistSongs[count - 1]
        } else {
            delegate?.changePlayingTrack(type: .Previous)
            prevEpisode = playlistSongs[index - 1]
        }
        
        self.song = prevEpisode
    }
    
    @objc fileprivate func handleNextTrack() {
        
        guard let playlistSongs = self.playlistSongs  else { return }

        if playlistSongs.count == 0 {
            return
        }
        
        let currentEpisodeIndex = playlistSongs.firstIndex { (ep) -> Bool in
            return self.song.audio_name == ep.audio_name && self.song.artist_name == ep.artist_name
        }
        
        guard let index = currentEpisodeIndex else { return }
        
        let nextEpisode: Audio
        if index == playlistSongs.count - 1 {
            delegate?.changePlayingTrack(type: .NewPlaylist)
            nextEpisode = playlistSongs[0]
        } else {
            delegate?.changePlayingTrack(type: .Next)
            nextEpisode = playlistSongs[index + 1]
        }
        self.song = nextEpisode
    }
    
    @objc func handlePlayPause() {
        print("Trying to play and pause")
        if player.timeControlStatus == .paused {
            player.play()
            delegate?.changePlayingTrack(type: .Play)
            enlargeEpisodeImageView()
            let pauseImage = UIImage(systemName: "pause.fill")
            playPauseButton.setImage(#imageLiteral(resourceName: "ic_pause"), for: .normal)
            miniPlayPauseButton.setImage(pauseImage, for: .normal)
            self.setupElapsedTime(playbackRate: 1)
        } else {
            player.pause()
            delegate?.changePlayingTrack(type: .Pause)
            shrinkEpisodeImageView()
            let playImage = UIImage(systemName: "play.fill")
            playPauseButton.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
            miniPlayPauseButton.setImage(playImage, for: .normal)
            self.setupElapsedTime(playbackRate: 0)
        }
    }
    
    
    fileprivate func observeBoundaryTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        
        // player has a reference to self
        // self has a reference to player
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            print("Episode started playing")
            self?.enlargeEpisodeImageView()
            self?.setupLockscreenDuration()
        }
    }
    
    fileprivate func setupLockscreenDuration() {
        guard let duration = player.currentItem?.duration else { return }
        let durationSeconds = CMTimeGetSeconds(duration)
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPMediaItemPropertyPlaybackDuration] = durationSeconds
    }
    
    
    fileprivate func setupInterruptionObserver() {
        // don't forget to remove self on deinit
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.interruptionNotification, object: nil)
    }
    
    @objc fileprivate func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        guard let type = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt else { return }
        
        if type == AVAudioSession.InterruptionType.began.rawValue {
            print("Interruption began")
            let playImage = UIImage(systemName: "play.fill")
            self.playPauseButton.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
            self.miniPlayPauseButton.setImage(playImage, for: .normal)
            
        } else {
            print("Interruption ended...")
            
            guard let options = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            
            if options == AVAudioSession.InterruptionOptions.shouldResume.rawValue {
                player.play()
                let pauseImage = UIImage(systemName: "pause.fill")
                self.playPauseButton.setImage(#imageLiteral(resourceName: "ic_pause"), for: .normal)
                self.miniPlayPauseButton.setImage(pauseImage, for: .normal)
            }
            
            
        }
    }
    
    //MARK: - Play Method
    fileprivate func playSong() {
        guard let url = URL(string: song.audio_url) else { return }
        
        let pauseImage = UIImage(systemName: "pause.fill")
        miniPlayPauseButton.setImage(pauseImage, for: .normal)
        self.playPauseButton.setImage(#imageLiteral(resourceName: "ic_pause"), for: .normal)
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        //Обсервер на конец песни
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        player.play()
    }
    
    //MARK: Вызывается когда заканчивается предыдущая песня
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.handleNextTrack()
    }
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRemoteControl()
        setupGestures()
        setupInterruptionObserver()
        observePlayerCurrentTime()
        observeBoundaryTime()
    }
    
    
    static func initFromNib() -> PlayerDetailsView {
        return Bundle.main.loadNibNamed("PlayerDetailsView", owner: self, options: nil)?.first as! PlayerDetailsView
    }
    
    //MARK: - IBOutlets

    //MARK: Mini View Outlets
    @IBOutlet weak var miniEpisodeImageView: UIImageView!
    @IBOutlet weak var miniNextButton: UIButton! {
        didSet {

            miniNextButton.addTarget(self, action: #selector(handleNextTrack), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var miniTitleLabel: UILabel!
    @IBOutlet weak var miniPlayerView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var miniPlayPauseButton: UIButton! {
        didSet{
            miniPlayPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
            miniPlayPauseButton.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        }
    }
    
    fileprivate let shrunkenTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
    fileprivate func shrinkEpisodeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = self.shrunkenTransform
            self.imageForBackground.transform = self.shrunkenTransform
            self.songTextView.transform = self.shrunkenTransform
        })
    }
    
    fileprivate func enlargeEpisodeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = .identity
            self.imageForBackground.transform = .identity
            self.songTextView.transform = .identity
        })
    }
    
    //MARK: - Player Outlets
    @IBOutlet weak var imageForBackground: UIImageView!
    
    @IBOutlet weak var songTextView: UITextView! {
        didSet{
            songTextView.isEditable = false
        }
    }
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView! {
        didSet{
            episodeImageView.clipsToBounds = true
            episodeImageView.cornerRadius = 12
            episodeImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            playPauseButton.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        }
    }
    
    //MARK: - IBActions
    @IBAction func handleDismiss(_ sender: Any) {
        
        let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.minimizePlayerDetails()
        
    }
    
    
    @IBAction func handleVolumeChange(_ sender: UISlider) {
        player.volume = sender.value
    }
    @IBAction func handleRewind(_ sender: Any) {
        seekToCurrentTime(delta: -15)
    }
    
    @IBAction func handleFastForward(_ sender: Any) {
        seekToCurrentTime(delta: 15)
    }
    
    @IBAction func handleCurrentTimeSliderChange(_ sender: Any) {
        let percentage = currentTimeSlider.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = seekTimeInSeconds
        
        player.seek(to: seekTime)
    }
    
    //MARK: - seekToCurrentTime
    fileprivate func seekToCurrentTime(delta: Int64) {
        let fifteenSeconds = CMTimeMake(value: delta, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), fifteenSeconds)
        player.seek(to: seekTime)
    }
}
