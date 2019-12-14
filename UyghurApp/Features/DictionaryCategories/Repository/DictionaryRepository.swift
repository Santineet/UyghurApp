//
//  DictionaryRepository.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/25/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift

class DictionaryRepository: NSObject {
    
    func setupDictinaryCategoriesListener() -> Observable<(EventType, DictionaryCategory)> {
        return Observable.create({ (observer) -> Disposable in
            API.instance.setupDictinaryCategoriesListener(onSuccess: { (eventType, dictionaryCategory) in
                observer.onNext((eventType, dictionaryCategory))
            }) { (errorMessage) in
                observer.onError(NSError(domain: errorMessage, code: 1, userInfo: nil))
            }
            return Disposables.create()
        })
    }
    
    func setupDictinaryWordsListener(category_name: String) -> Observable<(EventType, DictionaryWord)> {
        return Observable.create({ (observer) -> Disposable in
            API.instance.setupDictinaryWordsListener(category_name: category_name, onSuccess: { (eventType, dictionaryWord) in
                observer.onNext((eventType, dictionaryWord))
            }) { (errorMessage) in
                observer.onError(NSError(domain: errorMessage, code: 1, userInfo: nil))
            }
            return Disposables.create()
        })
    }
}
