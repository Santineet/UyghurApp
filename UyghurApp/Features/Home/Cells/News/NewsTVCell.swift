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
    @IBOutlet weak var allNewsLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
  
    var newsArray = [NewsModel]()  {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var link: HomeVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedAllNewsLabel))
        self.allNewsLabel.isUserInteractionEnabled = true
        self.allNewsLabel.addGestureRecognizer(tap)
        
        setupCollectionView()
    }

    @objc func didTappedAllNewsLabel() {
        HidePlayer.instance.hide()

        self.link?.didTappedAllNewsLabel()
    }
    
    //MARK: - setup CollectionView
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func didTappedTitle(new: NewsModel) {
        self.link?.didTappedNew(new: new)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NewsTVCell: UICollectionViewDelegate, UICollectionViewDataSource{
 
    //MARK: - CollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    //MARK: - CollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let new = self.newsArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCVCell", for: indexPath) as! NewsCVCell
        cell.link = self
        cell.new = new
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let new = newsArray[indexPath.row]
        HidePlayer.instance.hide()

        if new.video_url != "" {
            self.link?.didTappedNewVideo(url: new.video_url)
        } else if new.image_url != "" {
             self.link?.didTappedNew(new: new)
        }
    }
}

extension NewsTVCell: UICollectionViewDelegateFlowLayout {

    //MARK: - CollectionView layout
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
    return CGSize(width: 155, height: 300)
    }
}
