//
//  HiestoriesVC.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/2/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift

class HistoriesVC: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var forYourLabel: UILabel!
    @IBOutlet weak var importantLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let forYouHistoryCell = "forYouHistoryCell"
    let impHistoryCell = "impHistoryCell"
    
    var historiesVM: HistoriesVM?
    let dispose = DisposeBag()
    
    var infoViewForImportant: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 0.12)
        view.layer.cornerRadius = 12
        return view
    }()
    
    var infoTextViewForImportant: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()

    var infoViewForForYour: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 0.12)
        view.layer.cornerRadius = 12
        return view
    }()
    
    var infoTextViewForForYour: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    var filteredHistories = [History]()
    var histories = [History]() {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupListeners()
        setupUI()
        setupInfoViewForImportant()
        setupInfoViewForYour()
        
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupInfoViewForImportant() {
        
        collectionView.addSubview(infoViewForImportant)
        let sizeForEstimate = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: "emptySearchResultLabel".localized).boundingRect(with: sizeForEstimate, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], context: nil)
        
        infoViewForImportant.anchor(top: collectionView.topAnchor, left: collectionView.leftAnchor, bottom: nil, right: collectionView.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: estimatedFrame.width + 16, height: estimatedFrame.height + 36)
        infoViewForImportant.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInfoTextViewForImportant()
    }
    
    fileprivate func setupInfoTextViewForImportant() {
        
        infoViewForImportant.addSubview(infoTextViewForImportant)
        infoTextViewForImportant.text = "emptySearchResultLabel".localized
        infoTextViewForImportant.anchor(top: infoViewForImportant.topAnchor, left: infoViewForImportant.leftAnchor, bottom: infoViewForImportant.bottomAnchor, right: infoViewForImportant.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    
    fileprivate func setupInfoViewForYour() {
        
        tableView.addSubview(infoViewForForYour)
        let sizeForEstimate = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: "emptySearchResultLabel".localized).boundingRect(with: sizeForEstimate, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], context: nil)
        
        infoViewForForYour.anchor(top: tableView.topAnchor, left: tableView.leftAnchor, bottom: nil, right: tableView.rightAnchor, paddingTop: 320, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: estimatedFrame.width + 16, height: estimatedFrame.height + 36)
        infoViewForForYour.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInfoTextViewForYour()
    }
    
    fileprivate func setupInfoTextViewForYour() {
        
        infoViewForForYour.addSubview(infoTextViewForForYour)
        infoTextViewForForYour.text = "emptySearchResultLabel".localized
        infoTextViewForForYour.anchor(top: infoViewForForYour.topAnchor, left: infoViewForForYour.leftAnchor, bottom: infoViewForForYour.bottomAnchor, right: infoViewForForYour.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "historyNavTitle".localized
        forYourLabel.text = "forYourLabel".localized
        importantLabel.text = "importantLabel".localized
        searchController.searchBar.placeholder = "searchPlaceholder".localized
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let impHistories: [History]
        if isFiltering {
            impHistories = self.filteredHistories.filter { (history) -> Bool in
                history.history_important == "true"
            }
        } else {
            impHistories = self.histories.filter { (history) -> Bool in
                history.history_important == "true"
            }
        }
        if impHistories.count == 0 {
            self.setupInfoViewForImportantHidden(isHidden: false)
            return 0
        }
        self.setupInfoViewForImportantHidden(isHidden: true)
        return impHistories.count
    }
    
    func setupInfoViewForImportantHidden(isHidden: Bool) {
        infoViewForImportant.isHidden = isHidden
        infoTextViewForImportant.isHidden = isHidden
    }
    
    func setupInfoViewForForYourHidden(isHidden: Bool) {
        infoViewForForYour.isHidden = isHidden
        infoTextViewForForYour.isHidden = isHidden
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "impHistoryCell", for: indexPath) as! ImpHistoryCell
        
        let impHirtories = self.histories.filter { (history) -> Bool in
            history.history_important == "true"
        }
        
        let history = impHirtories[indexPath.item]
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        
        let attributed = NSMutableAttributedString(string: history.history_title + "\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 18), .foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle: style])
        
        attributed.append(NSMutableAttributedString(string: history.history_description, attributes: [.font : UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle: style]))
        
        if history.history_important == "true" {
            
            cell.historyTitle.attributedText = attributed
            cell.iv.sd_setImage(with: URL(string: history.history_image_url))
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let impHirtories = self.histories.filter { (history) -> Bool in
            history.history_important == "true"
        }
        
        let history = impHirtories[indexPath.item]
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryDetailVC") as? HistoryDetailVC {
            if let navigator = navigationController {
                viewController.history = history
                navigator.pushViewController(viewController, animated: true) }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.histories.count == 0 {
            self.setupInfoViewForForYourHidden(isHidden: false)
            return 0
        }
        if isFiltering {
            if self.filteredHistories.count == 0 {
                self.setupInfoViewForForYourHidden(isHidden: false)
                return 0
            }
        }
        self.setupInfoViewForForYourHidden(isHidden: true)
        return isFiltering ? filteredHistories.count : self.histories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forYouHistoryCell", for: indexPath) as! ForYouHistoryCell
        let history = self.histories[indexPath.item]
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        
        let attributed = NSMutableAttributedString(string: history.history_title + "\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 18), .foregroundColor : UIColor.black, NSAttributedString.Key.paragraphStyle: style])
        
        attributed.append(NSMutableAttributedString(string: history.history_description, attributes: [.font : UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor : UIColor.lightGray, NSAttributedString.Key.paragraphStyle: style]))
        
        cell.historyTitle.attributedText = attributed
        cell.historyIV.sd_setImage(with: URL(string: history.history_image_url))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = self.histories[indexPath.item]
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryDetailVC") as? HistoryDetailVC {
            if let navigator = navigationController {
                viewController.history = history
                navigator.pushViewController(viewController, animated: true) }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
