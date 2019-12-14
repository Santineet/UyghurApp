//
//  NewsRepository.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/26/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift

class NewsRepository: NSObject {
    
    func setupNewsListener() -> Observable<(EventType, New)> {
        return Observable.create({ (observer) -> Disposable in
            
            API.instance.setupNewsListener(onSuccess: { (eventType, new) in
                observer.onNext((eventType, new))
            }) { (errorMessage) in
                observer.onError(NSError(domain: errorMessage, code: 1, userInfo: nil))
            }
            return Disposables.create()
        })
    }
}
