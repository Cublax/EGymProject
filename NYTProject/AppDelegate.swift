//
//  AppDelegate.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!
    var context: Context!
    
    // MARK: - Private properties
    
    private var imageCache: NSCache<Key, Object>!
    
    private var stack: CoreDataStack!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
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
        
        coordinator = AppCoordinator(appDelegate: self,
                                     context: context)
        coordinator.start()
        return true
    }
}

