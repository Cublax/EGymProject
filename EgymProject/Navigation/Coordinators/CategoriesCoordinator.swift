//
//  CategoriesCoordinator.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class CategoriesCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Coordinator
    
    func start() {
        showCategoriesViewController()
    }
    
    private func showCategoriesViewController() {
        let viewController = screens.createCategoriesViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showFeedViewController(for category: String) {
        let viewController = screens.createListingViewController(delegate: self, category: category)
        presenter.show(viewController, sender: nil)
    }
    
    private func showArticleViewController(for article: VisibleArticle) {
        let viewController = screens.createArticleViewController(delegate: self, article: article)
        presenter.show(viewController, sender: nil)
    }
    
    func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension CategoriesCoordinator: CategoriesViewModelDelegate {
    func didSelectCategory(category: String) {
        showFeedViewController(for: category)
    }
}

extension CategoriesCoordinator: ListingViewModelDelegate {
    func didSelectArticle(article: VisibleArticle) {
        showArticleViewController(for: article)
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}

extension CategoriesCoordinator: ArticleViewModelDelegate {
    func showFullArticle(for link: String) {
        
    }
}
