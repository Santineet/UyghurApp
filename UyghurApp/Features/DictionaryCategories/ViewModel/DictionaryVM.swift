//
//  DictionaryVM.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/25/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DictionaryVM: NSObject {
    
    var dictionaryRepository: DictionaryRepository?
    
    let dispose = DisposeBag()
    let dictCategoryBR = BehaviorRelay<(EventType, DictionaryCategory)>(value: (EventType.Added, DictionaryCategory()))
    let dictWordBR = BehaviorRelay<(EventType, DictionaryWord)>(value: (EventType.Added, DictionaryWord()))
    let errorBR = BehaviorRelay<Error>(value: NSError.init())
    
    func setupDictinaryCategoriesListener() {
        
        self.dictionaryRepository = DictionaryRepository()
        self.dictionaryRepository!.setupDictinaryCategoriesListener()
            .subscribe(onNext: { (eventType, dictionaryCategory) in
                self.dictCategoryBR.accept((eventType, dictionaryCategory))
            }, onError: { (errorMessage) in
                self.errorBR.accept(errorMessage)
            }).disposed(by: self.dispose)
    }
    
    func setupDictinaryWordsListener(category_name: String) {
        
        self.dictionaryRepository = DictionaryRepository()
        self.dictionaryRepository?.setupDictinaryWordsListener(category_name: category_name)
            .subscribe(onNext: { (eventType, dictionaryWord) in
                self.dictWordBR.accept((eventType, dictionaryWord))
            }, onError: { (errorMessage) in
                self.errorBR.accept(errorMessage)
            }).disposed(by: self.dispose)
    }
}
