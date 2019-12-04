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
    
    func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension FeedCoordinator: ListingViewModelDelegate {
    func didSelectArticle(article: VisibleArticle) {
    
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}
