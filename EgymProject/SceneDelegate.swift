//
//  SceneDelegate.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator!
    var context: Context!
    
    // MARK: - Private properties
    
    private var imageCache: NSCache<Key, Object>!
    
    private var stack: CoreDataStack!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window!.makeKeyAndVisible()
        imageCache = NSCache<Key, Object>()
        
        let client = HTTPClient(engine: .urlSession(.default))
        
        let imageRepository = ImageRepository(networkClient: client)
        
        let imageProvider = ImageProvider(repository: imageRepository,
                                          cache: self.imageCache)
        
        stack = CoreDataStack(modelName: "Model",
                              type: .prod)
        
        context = Context(stack: stack,
                          networkClient: client,
                          imageProvider: imageProvider)
        
        coordinator = AppCoordinator(sceneDelegate: self,
                                     context: context)
        coordinator.start()
    }
    
}

