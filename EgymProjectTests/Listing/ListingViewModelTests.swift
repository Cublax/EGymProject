//
//  ListingViewModelTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 05/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import EgymProject

fileprivate final class MockListingRepository: ListingRepositoryType {
    var article = [VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")]
    func getArticles(success: @escaping ([VisibleArticle]) -> Void, failure: @escaping (() -> Void)) {
        success(article)
    }
}

fileprivate final class MockListingViewModelDelegate: ListingViewModelDelegate {
    var article = VisibleArticle(category: "", title: "", author: "", subTitle: "", urlArticle: "", smallPictureUrl: "", bigPictureUrl: "")
       var alert: AlertType? = nil
    
    func didSelectArticle(article: VisibleArticle) {
        self.article = article
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }
}


fileprivate final class ListingViewModelTests: XCTestCase {

    func testGivenAListingViewModelWhenDidSelectAnArticleThenDelegateIsCorrectlyCalled() {
        let article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        let repository = MockListingRepository()
        let delegate = MockListingViewModelDelegate()
        let viewModel = ListingViewModel(repository: repository, delegate: delegate)
        
        let expectedResult = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        
         viewModel.viewDidLoad()
        viewModel.didSelectArticle(with: article)
        
        XCTAssertEqual(delegate.article, expectedResult)
    }


}
