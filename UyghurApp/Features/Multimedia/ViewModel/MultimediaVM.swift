//
//  MultimediaVM.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 12/3/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MultimediaVM: NSObject {
    
    var multimediaRepository: MultimediaRepository?
    
    let dispose = DisposeBag()
    let videosBR = BehaviorRelay<(EventType, Video)>(value: (EventType.Added, Video()))
    let audiosBR = BehaviorRelay<(EventType, Audio)>(value: (EventType.Added, Audio()))
    let errorBR = BehaviorRelay<Error>(value: NSError.init())
    
    func setupVideosListener() {
        
        self.multimediaRepository = MultimediaRepository()
        self.multimediaRepository?.setupVideosListener()
            .subscribe(onNext: { (eventType, new) in
                self.videosBR.accept((eventType, new))
            }, onError: { (errorMessage) in
                self.errorBR.accept(errorMessage)
            }).disposed(by: self.dispose)
    }

    func setupAudiosListener() {
        
        self.multimediaRepository = MultimediaRepository()
        self.multimediaRepository?.setupAudiosListener()
            .subscribe(onNext: { (eventType, audio) in
                self.audiosBR.accept((eventType, audio))
            }, onError: { (errorMessage) in
                self.errorBR.accept(errorMessage)
            }).disposed(by: self.dispose)
    }
}
