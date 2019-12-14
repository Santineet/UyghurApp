//
//  TranslationRepository.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/26/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift

class TranslationRepository: NSObject {
    
    func setupTranslationsListener() -> Observable<(EventType, Translation)> {
        return Observable.create({ (observer) -> Disposable in
            API.instance.setupTranslationsListener(onSuccess: { (eventType, translation) in
                observer.onNext((eventType, translation))
            }) { (errorMessage) in
                observer.onError(NSError(domain: errorMessage, code: 1, userInfo: nil))
            }
            return Disposables.create()
        })
    }
    
}
