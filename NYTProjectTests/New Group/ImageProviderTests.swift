//
//  ImageProviderTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 06/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

@testable import EgymProject
import XCTest

final class MockImageRepository: ImageRepositoryType {

    var data: Data? = nil

    func downloadImage(for url: URL,
                       cancelledBy cancellationToken: RequestCancellationToken,
                       callback: @escaping (Data?) -> Void) {
        callback(data)
    }
}

final class ImageProviderTests: XCTestCase {

    let mockRepository = MockImageRepository()

    func testWhenSetImageFromURL_DataIsCorrectlyReturned() {
        let cache = NSCache<Key, Object>()
        let imageProvider = ImageProvider(repository: mockRepository,
                                          cache: cache)
        let data =  UIImage(named: "new-york-times-logo")!.pngData()!
        mockRepository.data = data

        let expectation = self.expectation(description: "callback block was executed")
        let token = RequestCancellationToken()

        imageProvider.setImage(for: URL(string: "https://www.apple.com/")!,
                               cancelledBy: token,
                               callback: { image in
                                XCTAssertEqual(image?.pngData(), UIImage(data: data)?.pngData())
                                expectation.fulfill()
        })
    
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
