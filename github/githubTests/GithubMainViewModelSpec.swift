//
//  GithubMainViewModelSpec.swift
//  githubTests
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking
@testable import github

class GithubMainViewModelSpec: XCTestCase {
    
    var sut : GithubMainViewModel!

    func testProvidingDataFromGithub() {
        let searchResult = SearchResult(totalCount: 5, incompleteResults: false, items: [])
        let mockGithubSearchProvider = MockGithubSearchProvider()
        mockGithubSearchProvider.stubbedResult = Observable<SearchResult>.just(searchResult)
        sut = GithubMainViewModel(provider: mockGithubSearchProvider)
        TestHelper.doInTheSecond {
            self.sut.search("githubsearch")
        }
        let result = try? sut.searchResult().toBlocking(timeout: 3).first()
        XCTAssertEqual(result?.totalCount, 5, "Should be the same value")
        XCTAssertTrue(result?.items?.isEmpty ?? false)
    }
}


