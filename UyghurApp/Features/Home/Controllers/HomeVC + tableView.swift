//
//  HomeVC + tableView.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/7/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    //MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryTVCell", for: indexPath) as! DictionaryTVCell
            cell.link = self
            cell.selectionStyle = .none
            cell.categories = self.categories
            cell.dictionaryLabel.text = "dictionaryLabel".localized
            cell.allDictionariesLabel.text = "allLabel".localized
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVCell", for: indexPath) as! NewsTVCell
            cell.link = self
            cell.newsLabel.text = "newsLabel".localized
            cell.allNewsLabel.text = "allLabel".localized
            cell.selectionStyle = .none
            cell.newsArray = self.news
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideosTVCell", for: indexPath) as! VideosTVCell
            cell.link = self
            cell.videos = self.videos
            cell.videoLabel.text = "videosLabel".localized
            cell.allVideosLabel.text = "allLabel".localized
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongsTVCell", for: indexPath) as! SongsTVCell
            cell.link = self
            cell.audiosLabel.text = "audiosLabel".localized
            cell.allAudiosLabel.text = "allLabel".localized
            cell.selectionStyle = .none
            cell.audios = self.audios
            cell.link = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTVCell", for: indexPath) as! ProductsTVCell
            cell.link = self
            cell.productsLabel.text = "storeLabel".localized
            cell.allProductsLabel.text = "allLabel".localized
            cell.selectionStyle = .none
            cell.products = self.products
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTVCell", for: indexPath) as! HistoryTVCell
            cell.link = self
            cell.historiesLabel.text = "historiesLabel".localized
            cell.allHistoriesLabel.text = "allLabel".localized
            cell.histories = self.histories
            if self.histories.count >= 3 {
                cell.selectionStyle = .none
                cell.firstImage.sd_setImage(with: URL(string: self.histories[0].image_url ), placeholderImage: nil)
                cell.firstTitle.text = self.histories[0].title
                
                cell.secondImage.sd_setImage(with: URL(string: self.histories[1].image_url), placeholderImage: nil)
                cell.secondTitle.text = self.histories[1].title
                cell.thirdImage.sd_setImage(with: URL(string: self.histories[2].image_url), placeholderImage: nil)
                cell.thirdTitle.text = self.histories[2].title
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    //MARK: - heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0: return 185
        case 1: return 354
        case 2: return 310
        case 3: return 300
        case 4: return 354
        case 5: return 345
        default: return 100
        }
    }
}
