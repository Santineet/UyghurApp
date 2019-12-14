//
//  DictionaryTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class DictionaryTVCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dictionaryLabel: UILabel!
    @IBOutlet weak var allDictionariesLabel: UILabel!
    
    public var categories = [DictionaryCategoriesModel]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var link: HomeVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedAllDictionariesLabel))
        self.allDictionariesLabel.isUserInteractionEnabled = true
        self.allDictionariesLabel.addGestureRecognizer(tap)
        
        setupCollectionView()
    }
    
    @objc func didTappedAllDictionariesLabel() {
        
        self.link?.didTappedAllDictionariesLabel()
    }
    
    //MARK: - setup CollectionView
    func setupCollectionView(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


//MARK: -  UICollectionView Delegate
extension DictionaryTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: -  UICollectionView numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.categories.count <= 3 {
            return 1
        } else if self.categories.count % 3 == 0 {
            return self.categories.count  % 3
        } else {
            return self.categories.count  % 3 + 1
        }
    }
    
    //MARK: -  UICollectionView cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DictionaryCVCell", for: indexPath) as! DictionaryCVCell
        
        cell.index = indexPath.row
        cell.link = self
        cell.categories = self.categories
        cell.tableView.reloadData()
        return cell
    }
    
    func didTappedDictionary(category: DictionaryCategoriesModel) {
        self.link?.didTappedDictionary(dictCategory: category)
    }
    
}

extension DictionaryTVCell: UICollectionViewDelegateFlowLayout {
    
    //MARK: -  UICollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath:IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
}
