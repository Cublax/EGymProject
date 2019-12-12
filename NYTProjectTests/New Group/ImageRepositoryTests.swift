//
//  ImageRepositoryTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 06/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import EgymProject

final class ImageRepositoryTests: XCTestCase {

    func testGivenAnImageRepository_WhenSendDownloadImage_callbackIsCalled() {
        var mockHTTPClient: HTTPClient {return HTTPClient(engine: .urlSession(.default))}
        let repository = ImageRepository(networkClient: mockHTTPClient)
        let expectation = self.expectation(description: "callback block was executed")
        let cancellationToken = RequestCancellationToken()

        repository.downloadImage(for: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg")!,
                                 cancelledBy: cancellationToken,
                                 callback: { _ in
                                    expectation.fulfill()
        })

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
