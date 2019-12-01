//
//  HomeRepository.swift
//  UyghurApp
//
//  Created by Mairambek on 11/25/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//


import Foundation
import RxSwift

class HomeRepository: NSObject {
    
    //    MARK:    Function to retrieve news from databse.
    //    MARK:    Функция для получения новостей из базы данных.
    func getNews() -> Observable<[NewsModel]>{
        return Observable.create({ (observer) -> Disposable in
            ServiceManager.instance.getNews { (newsArray, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    guard let news = newsArray as? [NewsModel] else { return }
                    observer.onNext(news)
                }
            }
            return Disposables.create()
        })
    }
    

}


