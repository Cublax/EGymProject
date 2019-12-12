//
//  FeedCoordinator.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class FeedCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    
    private let screens: Screens
    
    private let category = "home"
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Coordinator
    
    func start() {
        showFeedViewController()
    }
    
    private func showFeedViewController() {
        let viewController = screens.createListingViewController(delegate: self, category: category)
        presenter.viewControllers = [viewController]
    }
    
    private func showArticleViewController(for article: VisibleArticle) {
        let viewController = screens.createArticleViewController(delegate: self, article: article)
        presenter.show(viewController, sender: nil)
    }
    
    private func showWebViewController(for article: VisibleArticle) {
        let viewController = screens.createWebViewViewController(article: article)
        presenter.show(viewController, sender: nil)
    }
    
    private func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension FeedCoordinator: ListingViewModelDelegate {
    func didSelectArticle(article: VisibleArticle) {
        showArticleViewController(for: article)
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}

extension FeedCoordinator: ArticleViewModelDelegate {
    func showFullArticle(for article: VisibleArticle) {
        showWebViewController(for: article)
    }
}
