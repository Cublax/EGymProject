//
//  ListingRepositoryTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 06/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import EgymProject

final class ListingRepositoryTests: XCTestCase {
    var mockHTTPClient: HTTPClient {
        return HTTPClient(engine: .urlSession(.default))
    }
    
    func testGivenAlistingRepositoryWhenMakeARequestThenIsSuccess() {
        let repository = ListingRepository(networkClient: mockHTTPClient,
                                           category: "arts")
        
        let expectation = self.expectation(description: "The response is a success")

        repository.getArticles(success: { _ in
            expectation.fulfill()
        }, failure: {
            XCTFail()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGivenAlistingRepositoryWhenMakeARequestThenIsFailure() {
        let repository = ListingRepository(networkClient: mockHTTPClient,
                                           category: "TOTO")
        
        let expectation = self.expectation(description: "The response is a fail")

        repository.getArticles(success: { _ in
            XCTFail()
        }, failure: {
             expectation.fulfill()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

final class FavoriteListingRepositoryTests: XCTestCase {
    
    func testGivenAListingFavoriteRepositoryWhenMakeARequestInCoreDataThenIsCorrectlyReturned() {
        let stack = CoreDataStack(modelName: "Model",
                                  type: .test)
        let repository = FavoriteListingRepository(stack: stack)
        
        let expectation = self.expectation(description: "The response is a success")
        
        repository.getArticles(success: { _ in
            expectation.fulfill()
        }, failure: {
            XCTFail()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
