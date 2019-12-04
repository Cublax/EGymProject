//
//  FavoriteCoordinator.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class FavoriteCoordinator {
    
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
        showFavoriteViewController()
    }
    
    private func showFavoriteViewController() {
        let viewController = screens.createFavoriteListingViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showArticleViewController(for article: VisibleArticle) {
        let viewController = screens.createArticleViewController(delegate: self, article: article)
        presenter.show(viewController, sender: nil)
    }
    
    private func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension FavoriteCoordinator: ListingViewModelDelegate {
    func didSelectArticle(article: VisibleArticle) {
        showArticleViewController(for: article)
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}

extension FavoriteCoordinator: ArticleViewModelDelegate {
    func showFullArticle(for link: String) {
        
    }
}

