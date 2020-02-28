//
//  MockGithubSearchProvider.swift
//  githubTests
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//
import RxSwift
@testable import github

class MockGithubSearchProvider: GithubSearchProtocol {
    var stubbedResult : Observable<SearchResult>!
    func search(_ text: String) -> Observable<SearchResult> {
        return stubbedResult
    }
}
