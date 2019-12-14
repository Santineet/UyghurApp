//
//  MultimediaVC + search.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/4/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension MultimediaVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText:String) {
        
        filteredVideos = self.videos.filter({ (video:Video) -> Bool in
            return video.video_title.lowercased().contains(searchText.lowercased())
        })
        self.videosCollectionView.reloadData()
        
        filteredAudios = self.audios.filter({ (audio:Audio) -> Bool in
            return audio.audio_name.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()
    }
    
}
