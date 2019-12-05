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

fileprivate final class MockCategoriesRepository: CategoriesRepositoryType {
    var dico = ["toto": "tutu"]
    func getCategories(callback: @escaping ([String : String]) -> Void) {
        callback(dico)
    }
}

fileprivate final class CategoriesViewModelTest: XCTestCase {
    
    func testGivenACategorieViewModelWhenViewDidLoadThenVisibleCategoriesSendAnArrayOfKeys() {
        let repository = CategoriesRepository()
        let delegate = MockCategoriesViewModelDelegate()
        let viewModel = CategoriesViewModel(repository: repository, delegate: delegate)
        
        
        let expectedResult = "arts"
        
        viewModel.viewDidLoad()
        viewModel.didSelectCategory(with: "Arts")
        
        XCTAssertEqual(delegate.category, expectedResult)
    }
    
    func testGivenACategorieViewModelWhenViewDidLoadThenVisibleCategorieAreCorrectlyReturned() {
        let repository = MockCategoriesRepository()
        let delegate = MockCategoriesViewModelDelegate()
        let viewModel = CategoriesViewModel(repository: repository, delegate: delegate)
        let expectation = self.expectation(description: "an array of keys is returned")
        
        let expectedResult = ["toto"]
        
        viewModel.visibleCategories = { answer in
            XCTAssertEqual(answer, expectedResult)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
