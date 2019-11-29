//
//  Context.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class Context {
    
    // MARK: - Public properties
    
    let networkClient: HTTPClient
    
    let imageProvider: ImageProvider
    
    //let stack: CoreDataStack
    
    // MARK: - Initializer
    
    init(networkClient: HTTPClient, imageProvider: ImageProvider) {
        self.networkClient = networkClient
        self.imageProvider = imageProvider
        //self.stack = stack
    }
}
