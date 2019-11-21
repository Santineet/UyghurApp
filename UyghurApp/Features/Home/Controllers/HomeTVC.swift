//
//  HomeTVC.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class HomeTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Главная"
        tableView.allowsSelection = false
    }


    //MARK: - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }

    //MARK: - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryTVCell", for: indexPath) as! DictionaryTVCell
            cell.alpha = 0
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideosTVCell", for: indexPath) as! VideosTVCell
            cell.alpha = 0
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
            
            return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongsTVCell", for: indexPath) as! SongsTVCell
            cell.alpha = 0
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
            
            return cell
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVCell", for: indexPath) as! NewsTVCell
            cell.alpha = 0
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
            
            return cell
      
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTVCell", for: indexPath) as! ProductsTVCell
            cell.alpha = 0
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
            
            return cell
            
        default:
            
            return UITableViewCell()
        }
        
    }
    
    //MARK: - heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 185
        case 1:
            return 310
        case 2:
            return 210
        case 3:
            return 235
        case 4:
            return 235
        default:
            return 100
        }
    }

}
