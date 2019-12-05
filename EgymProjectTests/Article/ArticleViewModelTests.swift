//
//  ArticleViewModelTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 05/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import EgymProject

fileprivate final class MockArticleRepository1: ArticleRepositoryType {
    
    var favorite = true
    func addToFavorite(article: VisibleArticle) {
    }
    
    func checkIfFavorite(title: String, completion: (Bool) -> Void) {
        completion(favorite)
    }
    
    func removeFavorite(title: String) {
    }
}

fileprivate final class MockArticleRepository2: ArticleRepositoryType {
    
    var favorite = false
    func addToFavorite(article: VisibleArticle) {
    }
    
    func checkIfFavorite(title: String, completion: (Bool) -> Void) {
        completion(favorite)
    }
    
    func removeFavorite(title: String) {
    }
}

fileprivate final class MockArticleRepositoryDelegate: ArticleViewModelDelegate {
    var article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
    func showFullArticle(for article: VisibleArticle) {
        self.article = article
    }
}

fileprivate final class ArticleViewModelTests: XCTestCase {
    
    func testGivenAnArticleViewModelWhenAViewDidLoadThenGetInformationIfFavorite() {
        let article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        let repository = MockArticleRepository1()
        let delegate = MockArticleRepositoryDelegate()
        let viewModel = ArticleViewModel(article: article, delegate: delegate, repository: repository)
        let expectation = self.expectation(description: "Returned true")
        
        viewModel.isFavorite = { answer in
            XCTAssertEqual(answer, true)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAnArticleViewModelWhenclickedOnFavoriteThenIsFavoriteReturnFalse() {
       let article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        let repository = MockArticleRepository1()
        let delegate = MockArticleRepositoryDelegate()
        let viewModel = ArticleViewModel(article: article, delegate: delegate, repository: repository)
        
        let expectation = self.expectation(description: "Returned true")
        
        var counter = 0
        viewModel.isFavorite = { answer in
            if counter == 1 {
                XCTAssertEqual(answer, false)
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.clickedOnFavorite()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAnArticleViewModelWhenclickedOnFavoriteThenIsFavoriteReturnTrue() {
        let article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        let repository = MockArticleRepository2()
        let delegate = MockArticleRepositoryDelegate()
        let viewModel = ArticleViewModel(article: article, delegate: delegate, repository: repository)
        
        let expectation = self.expectation(description: "Returned true")
        
        var counter = 0
        viewModel.isFavorite = { answer in
            if counter == 1 {
                XCTAssertEqual(answer, true)
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.clickedOnFavorite()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAnArticleViewModelWhenCallFuncOpenWebViewThenDelegateIsCorrectlyCalled() {
        let article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        let repository = MockArticleRepository1()
        let delegate = MockArticleRepositoryDelegate()
        let viewModel = ArticleViewModel(article: article, delegate: delegate, repository: repository)
        
        let expectedResult = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        
         viewModel.viewDidLoad()
        viewModel.openWebView()
        
        XCTAssertEqual(delegate.article, expectedResult)
    }
}
