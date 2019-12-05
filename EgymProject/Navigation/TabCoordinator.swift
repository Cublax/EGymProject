//
//  TabCoordinator.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

enum ViewControllerItem: Int {
    case feed = 0
    case categories = 1
    case favorite = 2
}

protocol TabBarSourceType {
    var items: [UINavigationController] {get set}
}

final class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]
    
    init() {
        tabBarIconInitializer()
    }
    
    private func tabBarIconInitializer() {
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.2134923041, green: 0.2007651627, blue: 0.196667999, alpha: 1)
        UITabBar.appearance().tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if let font = UIFont(name: "Copperplate", size: 15.0) {
            UITabBarItem.appearance().setTitleTextAttributes([.font: font],
                                                             for: .normal)
        }
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2134923041, green: 0.2007651627, blue: 0.196667999, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self[.feed].tabBarItem = UITabBarItem(title: "Feed", image: nil, tag: 0)
        self[.feed].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        self[.categories].tabBarItem = UITabBarItem(title: "Categories", image: nil, tag: 0)
        self[.categories].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        self[.favorite].tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 0)
        self[.favorite].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
    }
}

extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exist")
            }
            return items[item.rawValue]
        }
    }
}

final class TabCoordinator: NSObject {
    
    // MARK: - Properties
    
    private let presenter: UIWindow
    
    private let tabBarController: UITabBarController
    
    private let screens: Screens
    
    private var feedCoordinator: FeedCoordinator?
    
    private var categoriesCoordinator: CategoriesCoordinator?
    
    private var favoriteCoordinator: FavoriteCoordinator?
    
    private var source: TabBarSource = TabBarSource()
    
    // MARK: - Initializer
    
    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter
        
        self.screens = Screens(context: context)
        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = source.items
        tabBarController.selectedViewController = source[.feed]
        super.init()
        
        tabBarController.delegate = self
    }
    
    func start() {
        presenter.rootViewController = tabBarController
        showFeed()
    }
    
    private func showFeed() {
        feedCoordinator = FeedCoordinator(presenter: source[.feed], screens: screens)
        feedCoordinator?.start()
    }
    
    private func showCategories() {
        categoriesCoordinator = CategoriesCoordinator(presenter: source[.categories], screens: screens)
        categoriesCoordinator?.start()
    }
    
    private func showFavorite() {
        favoriteCoordinator = FavoriteCoordinator(presenter: source[.favorite], screens: screens)
        favoriteCoordinator?.start()
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < source.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Index out of range")
        }
        
        switch item {
        case .feed:
            showFeed()
        case .categories:
            showCategories()
        case .favorite:
            showFavorite()
        }
    }
}
