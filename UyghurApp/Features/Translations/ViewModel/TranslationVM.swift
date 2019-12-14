//
//  TranslationVM.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/26/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TranslationVM: NSObject {
    
    var translationRepository: TranslationRepository?
    
    let dispose = DisposeBag()
    let translationBR = BehaviorRelay<(EventType, Translation)>(value: (EventType.Added, Translation()))
    let errorBR = BehaviorRelay<Error>(value: NSError.init())
    
    
    func setupTranslationsListener() {
        
        self.translationRepository = TranslationRepository()
        self.translationRepository?.setupTranslationsListener()
            .subscribe(onNext: { (eventType, translation) in
                self.translationBR.accept((eventType, translation))
            }, onError: { (errorMessage) in
                self.errorBR.accept(errorMessage)
            }).disposed(by: self.dispose)
    }
    
}
