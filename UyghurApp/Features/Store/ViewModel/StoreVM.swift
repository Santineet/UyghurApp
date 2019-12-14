//
//  StoreVM.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/1/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StoreVM: NSObject {
    
    var storeRepository: StoreRepository?
    
    let dispose = DisposeBag()
    let storeBR = BehaviorRelay<(EventType, Store)>(value: (EventType.Added, Store()))
    let errorBR = BehaviorRelay<Error>(value: NSError.init())
    
    func setupStoreListener() {
        
        self.storeRepository = StoreRepository()
        self.storeRepository?.setupStoreListener()
            .subscribe(onNext: { (eventType, store) in
                self.storeBR.accept((eventType, store))
            }, onError: { (errorMessage) in
                self.errorBR.accept(errorMessage)
            }).disposed(by: self.dispose)
    }
}
