//
//  ImageRepository.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol ImageRepositoryType {
    func downloadImage(for url: URL, cancelledBy cancellationToken: RequestCancellationToken, callback: @escaping (Data?) -> Void)
}

final class ImageRepository: ImageRepositoryType {
    
    // MARK: - Properties
    
    private let networkClient: HTTPClient
    
    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }
    
    // MARK: - ImageRepositoryType
    
    func downloadImage(for url: URL,
                       cancelledBy cancellationToken: RequestCancellationToken,
                       callback: @escaping (Data?) -> Void) {
        let request = URLRequest(url: url)
        networkClient
            .executeTask(request, cancelledBy: cancellationToken)
            .processDataResponse { (response) in
                switch response.result {
                case .success(let data):
                    callback(data)
                case .failure:
                    callback(nil)
                }
        }
    }
}
