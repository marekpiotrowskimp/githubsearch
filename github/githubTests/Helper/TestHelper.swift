//
//  TestHelper.swift
//  githubTests
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//
import XCTest
import RxSwift
@testable import github

class TestHelper {
    static func doInTheSecond(_ action: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            action()
        }
    }
}
