//
//  Screens.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class Screens {
    
    // MARK: - Properties
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
    private let context: Context
    
    // MARK: - Initializer
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - ListingViewController

extension Screens {
    func createListingViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
        let viewModel = ListingViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - CategoriesViewController

extension Screens {
    func createCategoriesViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "CategoriesViewController") as! CategoriesViewController
        let viewModel = CategoriesViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - ArticleViewController

extension Screens {
    func createArticleViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ArticleViewController") as! ArticleViewController
        let viewModel = ArticleViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}

