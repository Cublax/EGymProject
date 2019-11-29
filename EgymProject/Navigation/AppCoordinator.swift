//
//  AppCoordinator.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Properties
    
    private unowned var sceneDelegate: SceneDelegate
    
    private let context: Context
    
    private var tabcoordinator: TabCoordinator?
    
    // MARK: - Initializer
    
    init(sceneDelegate: SceneDelegate, context: Context) {
        self.sceneDelegate = sceneDelegate
        self.context = context
    }
    
    // MARK: - Coordinator
    
    func start() {
        tabcoordinator = TabCoordinator(presenter: sceneDelegate.window!, context: context)
        tabcoordinator?.start()
    }
}
