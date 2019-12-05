//
//  WebViewViewModelTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 05/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import EgymProject

fileprivate final class MockWebViewRepository1: WebViewRepositoryType {
    
    var favorite = true
    func addToFavorite(article: VisibleArticle) {
    }
    
    func checkIfFavorite(title: String, completion: (Bool) -> Void) {
        completion(favorite)
    }
    
    func removeFavorite(title: String) {
    }
}

fileprivate final class MockWebViewRepository2: WebViewRepositoryType {
    
    var favorite = false
    func addToFavorite(article: VisibleArticle) {
    }
    
    func checkIfFavorite(title: String, completion: (Bool) -> Void) {
        completion(favorite)
    }
    
    func removeFavorite(title: String) {
    }
}

fileprivate final class RecipeViewModelTests: XCTestCase {
    
    func testGivenAWebViewViewModelWhenAViewDidLoadThenGetInformationIfFavorite() {
        let article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        let repository = MockWebViewRepository1()
        let viewModel = WebViewViewModel(article: article, repository: repository)
        let expectation = self.expectation(description: "Returned true")
        
        viewModel.isFavorite = { answer in
            XCTAssertEqual(answer, true)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAWebViewViewModelWhenclickedOnFavoriteThenIsFavoriteReturnFalse() {
       let article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        let repository = MockWebViewRepository1()
        let viewModel = WebViewViewModel(article: article, repository: repository)
        
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
    
    func testGivenAWebViewViewModelWhenclickedOnFavoriteThenIsFavoriteReturnTrue() {
        let article = VisibleArticle(category: "1", title: "1", author: "1", subTitle: "1", urlArticle: "1", smallPictureUrl: "1", bigPictureUrl: "1")
        let repository = MockWebViewRepository2()
        let viewModel = WebViewViewModel(article: article, repository: repository)
        
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
}
