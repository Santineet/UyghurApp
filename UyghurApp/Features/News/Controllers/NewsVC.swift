//
//  NewsVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/24/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage
import AVKit

class NewsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    private let newVCCell = "newVCCell"
    private let headerId = "headerId"
    
    var newsVM: NewsVM?
    let dispose = DisposeBag()
    
    var infoView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 0.12)
        view.layer.cornerRadius = 12
        return view
    }()
    
    var infoTextView: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    var filteredNews = [New]()
    var news = [New]() {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    var searchBarIsEmpty:Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    var isFiltering:Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNewsListener()
        setupSearchController()
        setupInfoView()
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        collectionView.contentInset = .init(top: 16, left: 8, bottom: 16, right: 8)
        collectionView.alwaysBounceVertical = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "newsNavTitle".localized
        searchController.searchBar.placeholder = "searchPlaceholder".localized
        collectionView.reloadData()
    }
    
    fileprivate func setupInfoView() {
        
        collectionView.addSubview(infoView)
        let sizeForEstimate = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: "emptySearchResultLabel".localized).boundingRect(with: sizeForEstimate, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], context: nil)
        
        infoView.anchor(top: collectionView.topAnchor, left: collectionView.leftAnchor, bottom: nil, right: collectionView.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: estimatedFrame.width + 16, height: estimatedFrame.height + 36)
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInfoTextView()
    }
    
    fileprivate func setupInfoTextView() {
        
        infoView.addSubview(infoTextView)
        infoTextView.text = "emptySearchResultLabel".localized
        infoTextView.anchor(top: infoView.topAnchor, left: infoView.leftAnchor, bottom: infoView.bottomAnchor, right: infoView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    func setupNewsListener() {
        
        self.newsVM = NewsVM()
        self.newsVM?.setupNewsListener()
        self.newsVM!.newBR.skip(1).subscribe(onNext: { (eventType, new) in
            switch eventType {
            case .Added:
                if let index = self.news.firstIndex(where: { (item) -> Bool in
                    return item.id == new.id
                }){
                    self.news[index] = new
                    self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                } else {
                    self.news.append(new)
                    self.collectionView.reloadData()
                }
                break
            case .Changed:
                if let index = self.news.firstIndex(where: { (item) -> Bool in
                    return item.id == new.id
                }){
                    self.news[index] = new
                    self.collectionView.reloadData()
                }
                break
            case .Removed:
                if let index = self.news.firstIndex(where: { (item) -> Bool in
                    return item.id == new.id
                }){
                    self.news.remove(at: index)
                    self.collectionView.reloadData()
                }
                break
            }
        }).disposed(by: dispose)
    }
    
    func setupSearchController() {
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func setInfoViewHidden(isHidden: Bool) {
        infoView.isHidden = isHidden
        infoTextView.isHidden = isHidden
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.news.count == 0 {
            self.setInfoViewHidden(isHidden: false)
            return 0
        }
        if isFiltering {
            if self.filteredNews.count == 0 {
                self.setInfoViewHidden(isHidden: false)
                return 0
            }
        }
        self.setInfoViewHidden(isHidden: true)
        return isFiltering ? filteredNews.count : self.news.count
    }
    
    static var index: Int = 0
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newVCCell, for: indexPath) as! NewCell
        var new: New
        if isFiltering {
            new = self.filteredNews[indexPath.row]
        } else { new =  self.news[indexPath.item] }
        cell.new = new
        cell.link = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width-18)/2
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var new: New
        if isFiltering {
            new = self.filteredNews[indexPath.row]
        } else { new =  self.news[indexPath.item] }
        
        if new.video_url != "" {
            let videoURL = URL(string: new.video_url)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        } else {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewDetailVC") as? NewDetailVC {
                if let navigator = navigationController {
                    viewController.new = new
                    navigator.pushViewController(viewController, animated: true) }
            }
        }
    }
    
    func didTappedReadButton(new: New?) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewDetailVC") as? NewDetailVC {
            if let navigator = navigationController {
                viewController.new = new
                navigator.pushViewController(viewController, animated: true) }
        }
    }
}

extension NewsVC: PinterestLayoutDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let new = self.news[indexPath.item]
        if new.image_url != "" {
            if new.height >= (Int(self.view.frame.height/3)) {
                return self.view.frame.height/3
            } else { return CGFloat(new.height) }
        }
        return  (self.view.frame.width-18)/2
    }
}

extension NewsVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText:String) {
        
        filteredNews = self.news.filter({ (new:New) -> Bool in
            return new.title.lowercased().contains(searchText.lowercased())
        })
        self.collectionView.reloadData()
    }
    
}
