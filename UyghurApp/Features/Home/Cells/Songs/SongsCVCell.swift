//
//  SongsCVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class SongsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    
    var audios = [AudiosModel]()
    var index = 0
    
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
        cell.nameSong.text = audio.audio_name
        cell.singerName.text = audio.artist_name
        cell.imageSong.sd_setImage(with: URL(string: audio.image_url), placeholderImage: nil)
        
        return cell
    }
    
    //MARK: - setup heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 54
    }
    
    
    
}
