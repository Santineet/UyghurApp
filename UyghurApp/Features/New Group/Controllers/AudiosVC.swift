//
//  AudiosVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift

class AudiosVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let audioCell = "audioCell"
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    
    var multimediaVM: MultimediaVM?
    let dispose = DisposeBag()
    
    var searchBarIsEmpty:Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    var isFiltering:Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var filteredAudios = [Audio]()
    var audios = [Audio]() {
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    var infoViewForAudios: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 0.12)
        view.layer.cornerRadius = 12
        return view
    }()
    
    var infoTextViewForAudios: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.playerDetailsView.audiosDelegate = self
        
        setupAudiosListener()
        setupSearchController()
        setupInfoViewForAudios()
        
        tableView.tableFooterView = UIView()
        tableView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    fileprivate func setupInfoViewForAudios() {
        
        tableView.addSubview(infoViewForAudios)
        let sizeForEstimate = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: "emptySearchResultLabel".localized).boundingRect(with: sizeForEstimate, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], context: nil)
        
        infoViewForAudios.anchor(top: tableView.topAnchor, left: tableView.leftAnchor, bottom: nil, right: tableView.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: estimatedFrame.width + 16, height: estimatedFrame.height + 36)
        infoViewForAudios.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInfoTextViewForAudios()
    }
    
    fileprivate func setupInfoTextViewForAudios() {
        
        infoViewForAudios.addSubview(infoTextViewForAudios)
        infoTextViewForAudios.text = "emptySearchResultLabel".localized
        infoTextViewForAudios.anchor(top: infoViewForAudios.topAnchor, left: infoViewForAudios.leftAnchor, bottom: infoViewForAudios.bottomAnchor, right: infoViewForAudios.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "audiosNavTitle".localized
        searchController.searchBar.placeholder = "searchPlaceholder".localized
    }
    
    fileprivate func setupSearchController() {
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func setupInfoViewForAudiosHidden(isHidden: Bool) {
         
         infoViewForAudios.isHidden = isHidden
         infoTextViewForAudios.isHidden = isHidden
     }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.audios.count == 0 {
            self.setupInfoViewForAudiosHidden(isHidden: false)
            return 0
        }
        if isFiltering {
            if self.filteredAudios.count == 0 {
                self.setupInfoViewForAudiosHidden(isHidden: false)
                return 0
            }
        }
        self.setupInfoViewForAudiosHidden(isHidden: true)
        return isFiltering ? filteredAudios.count : self.audios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: audioCell, for: indexPath) as! AudioCell
        var audio: Audio
        if isFiltering {
            audio = self.filteredAudios[indexPath.row]
        } else { audio =  self.audios[indexPath.item] }
        cell.audio = audio
        
        if let index = playingIndex, index == indexPath.row {
            
            if playing {
                let pauseImage = UIImage(systemName: "pause.fill")
                cell.playOrPauseIV.image = pauseImage
            } else {
                let playImage = UIImage(systemName: "play.fill")
                cell.playOrPauseIV.image = playImage
            }
        } else {
            let playImage = UIImage(systemName: "play.fill")
            cell.playOrPauseIV.image = playImage
        }        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var audio: Audio
        if isFiltering {
            audio = self.filteredAudios[indexPath.row]
        } else { audio =  self.audios[indexPath.item] }
        
        let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.playerDetailsView.isHidden = false
        mainTabBarController?.maximizePlayerDetails(song: audio, playlistSongs: audios)
        playingIndex = indexPath.row
        playing = true
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    
    fileprivate func setupAudiosListener() {
        
        self.multimediaVM = MultimediaVM()
        self.multimediaVM?.setupAudiosListener()
        self.multimediaVM!.audiosBR.skip(1).subscribe(onNext: { (eventType, audio) in
            switch eventType {
            case .Added:
                if let index = self.audios.firstIndex(where: { (item) -> Bool in
                    return item.id == audio.id
                }){
                    self.audios[index] = audio
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                } else {
                    self.audios.append(audio)
                    self.tableView.reloadData()
                }
                break
            case .Changed:
                if let index = self.audios.firstIndex(where: { (item) -> Bool in
                    return item.id == audio.id
                }){
                    self.audios[index] = audio
                    self.tableView.reloadData()
                }
                break
            case .Removed:
                if let index = self.audios.firstIndex(where: { (item) -> Bool in
                    return item.id == audio.id
                }){
                    self.audios.remove(at: index)
                    self.tableView.reloadData()
                }
                break
            }
        }).disposed(by: dispose)
    }
}

extension AudiosVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText:String) {
        
        filteredAudios = self.audios.filter({ (audio:Audio) -> Bool in
            return audio.audio_name.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()
    }
    
}

extension AudiosVC: ChangeAudiosPlayerTrackDelegate {
    func changePlayingTrack(type: TypeOfChange) {
        
        switch  type {
        case .Next:
            if playingIndex != nil {
//                self.playingIndex! += 1
                self.tableView.reloadData()
            }
        case .Pause:
//            self.playing = false
            self.tableView.reloadData()
        case .Previous:
            if playingIndex != nil {
//                self.playingIndex! -= 1
                self.tableView.reloadData()
            }
        case .NewPlaylist:
            if playingIndex != nil {
//                self.playingIndex! = 0
                self.tableView.reloadData()
            }
        case .PlayFromTheEnd:
            if playingIndex != nil {
//                let count = self.audios.count
//                self.playingIndex! = count - 1
                self.tableView.reloadData()
            }
            
        case .Play:
//            self.playing = true
            self.tableView.reloadData()
        }
    }
}
