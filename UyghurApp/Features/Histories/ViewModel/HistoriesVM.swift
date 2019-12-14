//
//  HistoryVM.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HistoriesVM: NSObject {
    
    var historiesRepository: HistoriesRepository?
    
    let dispose = DisposeBag()
    let historiesBR = BehaviorRelay<(EventType, History)>(value: (EventType.Added, History()))
    let errorBR = BehaviorRelay<Error>(value: NSError.init())
    
    func setupHistoriesListener() {
        
        self.historiesRepository = HistoriesRepository()
        self.historiesRepository?.setupHistoriesListener()
            .subscribe(onNext: { (eventType, history) in
                self.historiesBR.accept((eventType, history))
            }, onError: { (errorMessage) in
                self.errorBR.accept(errorMessage)
            }).disposed(by: self.dispose)
    }
    
}
