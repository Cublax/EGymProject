//
//  HTTPEngine.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

public typealias HTTPCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void
public typealias DownloadCompletionHandler = (URL?, HTTPURLResponse?, Error?) -> Void

public protocol HTTPEngine {
    func send(request: URLRequest, cancelledBy token: RequestCancellationToken, completion: @escaping HTTPCompletionHandler)
    func download(request: URLRequest, cancelledBy token: RequestCancellationToken, completionHandler: @escaping DownloadCompletionHandler)
}
