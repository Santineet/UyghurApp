//
//  HistoriesRepository.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift

class HistoriesRepository: NSObject {
    
    func setupHistoriesListener() -> Observable<(EventType, History)> {
        return Observable.create({ (observer) -> Disposable in
            
            API.instance.setupHistoriesListener(onSuccess: { (eventType, history) in
                observer.onNext((eventType, history))
            }) { (errorMessage) in
                observer.onError(NSError(domain: errorMessage, code: 1, userInfo: nil))
            }
            return Disposables.create()
        })
    }
    
}
