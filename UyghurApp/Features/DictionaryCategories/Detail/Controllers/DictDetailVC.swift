//
//  DictDetailVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/23/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift
import AVKit

class DictDetailVC: UIViewController {
    
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var presentDuration: UILabel!
    @IBOutlet weak var andDuration: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var andDurationActivity: UIActivityIndicatorView!
    
    let dictCellID = "dictCellID"
    var dictionaryCategory: DictionaryCategory?
    
    var dictionaryVM: DictionaryVM?
    let dispose = DisposeBag()
    
    var dictionary_words = [DictionaryWord]() {
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    var audioPlayer = AVAudioPlayer()
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dictionaryCategory = self.dictionaryCategory else { return }
        
        navigationItem.title = dictionaryCategory.category_name
        setupUI(dictionaryCategory)
        setupListeners(dictionaryCategory)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.deletePlayer()
    }
    
}
