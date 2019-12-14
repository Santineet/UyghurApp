//
//  StoreRepository.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift

class StoreRepository: NSObject {
    
    func setupStoreListener() -> Observable<(EventType, Store)> {
        return Observable.create({ (observer) -> Disposable in
            
            API.instance.setupStoreListener(onSuccess: { (eventType, store) in
                observer.onNext((eventType, store))
            }) { (errorMessage) in
                observer.onError(NSError(domain: errorMessage, code: 1, userInfo: nil))
            }
            return Disposables.create()
        })
    }
    
}
