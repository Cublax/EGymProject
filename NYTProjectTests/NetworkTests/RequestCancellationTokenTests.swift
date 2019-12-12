//
//  RequestCancellationTokenTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 05/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import EgymProject

final class RequestCancellationTokenTests: XCTestCase {

    func testItExecutesBlockWhenDeallocating() {
        let expectation = self.expectation(description: "`willDeallocate` block was executed")

        autoreleasepool {
            let token = RequestCancellationToken()
            token.willDeallocate = { expectation.fulfill() }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
