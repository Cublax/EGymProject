//
//  RequestCancellationToken.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

public class RequestCancellationToken {
    
    // MARK: - Lifecycle
    
    public init() {}
    
    deinit {
        willDeallocate?()
    }
    
    // MARK: - Internal
    
    internal var willDeallocate: (() -> Void)?
}
