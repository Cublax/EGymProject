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

protocol ListingViewModelDelegate: class {
    func didSelectArticle(recipe: VisibleArticle)
    func shouldDisplayAlert(for type: AlertType)
}

extension Screens {
    func createHomeViewController(delegate: ListingViewModelDelegate?, source: String) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
        let repository = ListingRepository(networkClient: context.networkClient, source: source)
        let viewModel = ListingViewModel(repository: repository,
                                         delegate: delegate)
        viewController.viewModel = viewModel
        viewController.imageProvider = context.imageProvider
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

// MARK: - Alert

extension Screens {
    func createAlert(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok",
                                   style: .cancel,
                                   handler: nil)
        alertController.addAction(action)
        return alertController
    }
}

