//
//  NewsTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

class NewsTVCell: UITableViewCell {

    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
  
    var newsArray = [NewsModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupCollectionView()
    }

    //MARK: - setup CollectionView
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func allNews(_ sender: UIButton) {
   
    }
    
}

extension NewsTVCell: UICollectionViewDelegate, UICollectionViewDataSource{
 
    //MARK: - CollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    //MARK: - CollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let news = self.newsArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCVCell", for: indexPath) as! NewsCVCell
        
        if news.video_url != "" {
            cell.playImage.isHidden = false
            if let thumbnailIndex = news.thumbnailIndex {
                cell.imageNews.image = news.images[thumbnailIndex]
            } else {
                cell.imageNews.image = UIImage(named: "videoPlayer")
            }
        } else {
            cell.playImage.isHidden = true
            cell.imageNews.sd_setImage(with: URL(string: news.image_url), placeholderImage: nil)
            
        }
        
        cell.titleNews.text = news.title
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let news = newsArray[indexPath.row]
        print(news.image_url)
        
    }
}

extension NewsTVCell: UICollectionViewDelegateFlowLayout {

    //MARK: - CollectionView layout
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
    return CGSize(width: 155, height: 190)
    
    }
}
