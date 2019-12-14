//
//  MultimediaVC + fetchData.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/4/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

extension MultimediaVC {
    
    func setupListeners() {
        
        setupVideosListener()
        setupAudiosListener()
    }
    
    fileprivate func setupVideosListener() {
        
        self.multimediaVM = MultimediaVM()
        self.multimediaVM?.setupVideosListener()
        self.multimediaVM!.videosBR.skip(1).subscribe(onNext: { (eventType, video) in
            switch eventType {
            case .Added:
                if let index = self.videos.firstIndex(where: { (item) -> Bool in
                    return item.id == video.id
                }){
                    self.videos[index] = video
                    self.videosCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                } else {
                    self.videos.append(video)
                    self.videosCollectionView.reloadData()
                }
                break
            case .Changed:
                if let index = self.videos.firstIndex(where: { (item) -> Bool in
                    return item.id == video.id
                }){
                    self.videos[index] = video
                    self.videosCollectionView.reloadData()
                }
                break
            case .Removed:
                if let index = self.videos.firstIndex(where: { (item) -> Bool in
                    return item.id == video.id
                }){
                    self.videos.remove(at: index)
                    self.videosCollectionView.reloadData()
                }
                break
            }
        }).disposed(by: dispose)
    }
    
    fileprivate func setupAudiosListener() {
        
        self.multimediaVM = MultimediaVM()
        self.multimediaVM?.setupAudiosListener()
        self.multimediaVM!.audiosBR.skip(1).subscribe(onNext: { (eventType, audio) in
            switch eventType {
            case .Added:
                if let index = self.audios.firstIndex(where: { (item) -> Bool in
                    return item.id == audio.id
                }){
                    self.audios[index] = audio
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                } else {
                    self.audios.append(audio)
                    self.tableView.reloadData()
                }
                break
            case .Changed:
                if let index = self.audios.firstIndex(where: { (item) -> Bool in
                    return item.id == audio.id
                }){
                    self.audios[index] = audio
                    self.tableView.reloadData()
                }
                break
            case .Removed:
                if let index = self.audios.firstIndex(where: { (item) -> Bool in
                    return item.id == audio.id
                }){
                    self.audios.remove(at: index)
                    self.tableView.reloadData()
                }
                break
            }
        }).disposed(by: dispose)
    }
}
