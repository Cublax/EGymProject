//
//  ArticleRepositoryTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 06/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

@testable import EgymProject
import XCTest
import CoreData

class ArticleRepositoryTests: XCTestCase {
    
    func testGivenAArticleRepositoryWhenAddedToFavoriteThenIsCorrectlyAdded() {
        let stack = CoreDataStack(modelName: "Model", type: CoreDataStackType.test)
        let repository = ArticleRepository(stack: stack)
        let article = VisibleArticle(category: "1",
                                     title: "1",
                                     author: "1",
                                     subTitle: "1",
                                     urlArticle: "1",
                                     smallPictureUrl: "1",
                                     bigPictureUrl: "1")
        
        let expectation1 = self.expectation(description: "Correctly added to Favorites")
        
        repository.addToFavorite(article: article)
        
        repository.checkIfFavorite(title: article.title) { (status) in
            XCTAssertEqual(status, true)
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAArticleRepositoryWhenRemoveFromFavoriteThenIsCorrectlyRemoved() {
        let stack = CoreDataStack(modelName: "Model", type: CoreDataStackType.test)
        let repository = ArticleRepository(stack: stack)
        let article = VisibleArticle(category: "1",
                                     title: "1",
                                     author: "1",
                                     subTitle: "1",
                                     urlArticle: "1",
                                     smallPictureUrl: "1",
                                     bigPictureUrl: "1")
        
        let expectation1 = self.expectation(description: "Correctly removed from Favorites")
        
        repository.addToFavorite(article: article)
        
        repository.removeFavorite(title: article.title)
        
        repository.checkIfFavorite(title: article.title) { (status) in
            XCTAssertEqual(status, false)
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}


