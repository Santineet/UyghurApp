//
//  NewsVM.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/26/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NewsVM: NSObject {
    
    var newsRepository: NewsRepository?
    
    let dispose = DisposeBag()
    let newBR = BehaviorRelay<(EventType, New)>(value: (EventType.Added, New()))
    let errorBR = BehaviorRelay<Error>(value: NSError.init())
    
    func setupNewsListener() {
        
        self.newsRepository = NewsRepository()
        self.newsRepository?.setupNewsListener()
            .subscribe(onNext: { (eventType, new) in
                self.newBR.accept((eventType, new))
            }, onError: { (errorMessage) in
                self.errorBR.accept(errorMessage)
            }).disposed(by: self.dispose)
    }
    
}
