//
//  GithubMainViewModel.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//
import RxSwift
import RxRelay

class GithubMainViewModel : BaseViewModel {
    private let provider: GithubSearchProtocol
    private let search = PublishSubject<String>()
    
    init(provider : GithubSearchProtocol = GithubProvider.shard) {
        self.provider = provider
    }
    
    public func search(_ text: String) {
        search.onNext(text)
    }
    
    func searchResult() -> Observable<SearchResult> {
        return search.flatMapLatest { [weak self] text -> Observable<SearchResult> in
            guard let self = self else {return Observable<SearchResult>.empty() }
            return self.provider.search(text)
        }
    }
}
