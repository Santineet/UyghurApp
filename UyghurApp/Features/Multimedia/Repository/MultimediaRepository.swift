//
//  MultimediaRepository.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift

class MultimediaRepository: NSObject {
    
    func setupVideosListener() -> Observable<(EventType, Video)> {
        return Observable.create({ (observer) -> Disposable in
            
            API.instance.setupVideosListener(onSuccess: { (eventType, video) in
                observer.onNext((eventType, video))
            }) { (errorMessage) in
                observer.onError(NSError(domain: errorMessage, code: 1, userInfo: nil))
            }
            return Disposables.create()
        })
    }
    
    func setupAudiosListener() -> Observable<(EventType, Audio)> {
        return Observable.create({ (observer) -> Disposable in
            
            API.instance.setupAudiosListener(onSuccess: { (eventType, audio) in
                observer.onNext((eventType, audio))
            }) { (errorMessage) in
                observer.onError(NSError(domain: errorMessage, code: 1, userInfo: nil))
            }
            return Disposables.create()
        })
    }
    
}
