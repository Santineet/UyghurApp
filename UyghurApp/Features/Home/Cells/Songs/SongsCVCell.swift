//
//  SongsCVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import SPStorkController

class SongsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    
    var audios = [AudiosModel]()
    var index = 0
    var link: HomeVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupTableView()
    }
    
    
    //MARK: - setup TableView
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SongsCVCell: UITableViewDelegate, UITableViewDataSource {
  
    //MARK: - setup numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let objectsCount = self.audios.count - 3 * index
               
        if objectsCount == 0 {
            return 0
        } else if objectsCount == 1 {
            return 1
        } else if objectsCount == 2 {
            return 2
        }

        return 3
    }
    
    //MARK: - setup cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let index = indexPath.row + self.index * 3

        let audio = self.audios[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongDetailTVCell", for: indexPath) as! SongDetailTVCell
        cell.nameSong.text = audio.name
        cell.singerName.text = audio.artist_name
        cell.imageSong.sd_setImage(with: URL(string: audio.image_url), placeholderImage: nil)
        cell.playButton.tag = indexPath.row
        cell.playButton.addTarget(self, action: #selector(playButtonPressed(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)        
          let songController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SongPlayerVC") as! SongPlayerVC
          let transitionDelegate = SPStorkTransitioningDelegate()
          songController.transitioningDelegate = transitionDelegate
          songController.modalPresentationStyle = .custom

        songController.audios = self.audios
        songController.index = indexPath.row
        
        guard link != nil else { return }
        
        link!.present(songController, animated: true, completion: nil)
    }
    
    //MARK: - setup heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 54
    }
    
    
    @objc func playButtonPressed(sender: UIButton){
        let indexPathRow = sender.tag

        print("button pressed")
        link?.playPressed(collectionIndex: self.index, indexPathRow: indexPathRow)
    }
    
    
}
