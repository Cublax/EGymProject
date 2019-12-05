//
//  CategoriesViewModelTests.swift
//  EgymProjectTests
//
//  Created by Alexandre Quiblier on 05/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import EgymProject

fileprivate final class MockCategoriesViewModelDelegate: CategoriesViewModelDelegate {
    var category = "Science"
    func didSelectCategory(category: String) {
        self.category = category
    }
}

fileprivate final class CategoriesViewModelTest: XCTestCase {
    
    func testGivenACategorieViewModelWhenViewDidLoadThenVisibleCategoriesSendAnArrayOfKeys() {
        let repository = CategoriesRepository()
        let delegate = MockCategoriesViewModelDelegate()
        let viewModel = CategoriesViewModel(repository: repository, delegate: delegate)
        let expectation = self.expectation(description: "Array of keys match the expecation")
        
        let expectedResult: [String] = ["Arts",
                                        "Automobiles",
                                        "Books",
                                        "Business",
                                        "Fashion",
                                        "Food",
                                        "Health",
                                        "Home",
                                        "Insider",
                                        "Magazine",
                                        "Movies",
                                        "National",
                                        "New York Region",
                                        "Obituaries",
                                        "Opinion",
                                        "Politics",
                                        "Real Estate",
                                        "Science",
                                        "Sports",
                                        "Sunday Review",
                                        "Technology",
                                        "Theather",
                                        "T Magazine",
                                        "Travel",
                                        "The Upshot",
                                        "World"]
        
        viewModel.visibleCategories = { categories in
            //XCTAssertEqual(categories, expectedResult)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
