//
//  GithubImageProvider.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire

protocol GithubImageProtocol {
   func fetchImage(url: String) -> Observable<UIImage>
}

class GithubImageProvider : GithubImageProtocol{
    
    public static let shard : GithubImageProtocol = GithubImageProvider()
    private let sManager = SessionManager.default
    
    private init() {
    }
    
    func fetchImage(url: String) -> Observable<UIImage> {
        return sManager.rx.responseData(.get, url)
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMapLatest { responseData -> Observable<UIImage> in
                guard let data = UIImage(data: responseData.1) else {return Observable.empty()}
                return Observable.just(data)
            }.catchError({ (Error) -> Observable<UIImage> in
                return Observable.empty()
            }).observeOn(MainScheduler.instance)
    }
}
