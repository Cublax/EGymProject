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
    
    private let source = "home"
    
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
        let viewController = screens.createHomeViewController(delegate: self, source: source)
        presenter.viewControllers = [viewController]
    }
    
    func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension FeedCoordinator: ListingViewModelDelegate {
    func didSelectArticle(recipe: VisibleArticle) {
    
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}