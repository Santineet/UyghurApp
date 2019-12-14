//
//  HomeTVC.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit
import RxSwift
import PKHUD
import Network
import SPStorkController
import AVFoundation

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let monitor = NWPathMonitor()
    
    let homeVM = HomeViewModel()
    let disposeBag = DisposeBag()
    
    var news = [NewsModel]() {
        didSet { self.tableView.reloadData() }
    }
    var audios = [Audio]() {
        didSet { self.tableView.reloadData()  }
    }
    var videos = [VideosModel]() {
        didSet { self.tableView.reloadData() }
    }
    var categories = [DictionaryCategoriesModel]() {
        didSet { self.tableView.reloadData() }
    }
    var products = [StoreModel]() {
        didSet { self.tableView.reloadData() }
    }
    var histories = [HistoriesModel]() {
        didSet { self.tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupUI()
        setupObserverForInternetConnection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        self.navigationItem.title = "homeNavTitle".localized
    }
    
    func setupObserverForInternetConnection() {
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.fetchData()
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
}

struct Alert {
    
    static func displayAlert(title: String, message: String, vc: UIViewController)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}
