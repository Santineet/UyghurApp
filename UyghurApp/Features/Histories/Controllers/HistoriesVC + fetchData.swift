//
//  HistoriesVC + fetchData.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/4/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension HistoriesVC {
    
    func setupListeners() {
        
        setupHistoriesListener()
    }
    
    func setupHistoriesListener() {
        
        self.historiesVM = HistoriesVM()
        self.historiesVM?.setupHistoriesListener()
        self.historiesVM!.historiesBR.skip(1).subscribe(onNext: { (eventType, history) in
            switch eventType {
            case .Added:
                if let index = self.histories.firstIndex(where: { (item) -> Bool in
                    return item.id == history.id
                }){
                    self.histories[index] = history
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                } else {
                    self.histories.append(history)
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
                break
            case .Changed:
                if let index = self.histories.firstIndex(where: { (item) -> Bool in
                    return item.id == history.id
                }){
                    self.histories[index] = history
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
                break
            case .Removed:
                if let index = self.histories.firstIndex(where: { (item) -> Bool in
                    return item.id == history.id
                }){
                    self.histories.remove(at: index)
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
                break
            }
        }).disposed(by: dispose)
    }
}
