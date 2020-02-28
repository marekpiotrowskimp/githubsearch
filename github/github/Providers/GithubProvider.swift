//
//  GithubProvider.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import RxSwift
import RxRelay
import RxAlamofire
import Alamofire

protocol GithubSearch {
   func search(_ text: String) ->  Observable<SearchResult>
}

class GithubProvider : GithubSearch{
    private let sManager = SessionManager.default
    
    func search(_ text: String) ->  Observable<SearchResult> {
        return sManager.rx.responseData(.get, SearchQuery()[text])
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMapLatest { responseData -> Observable<SearchResult> in
                guard let data = try? JSONDecoder().decode(SearchResult.self, from: responseData.1 ) else {return Observable.never()}
                return Observable.just(data)
            }.catchError({ (Error) -> Observable<SearchResult> in
                return Observable.never()
            }).observeOn(MainScheduler.instance)
    }
    
}

struct SearchQuery {
    let baseAddress = "https://api.github.com/search/repositories"
    subscript(search:String) -> String {
        return "\(baseAddress)?q=\(search)&sort=stars&order=desc"
    }
}
