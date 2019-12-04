//
//  ListingRepository.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 02/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol ListingRepositoryType {
    func getArticles(success: @escaping ([VisibleArticle]) -> Void, failure: @escaping (() -> Void))
}


final class ListingRepository: ListingRepositoryType {
    
    // MARK: - Properties
    
    private let category: String
    
    private let networkClient: HTTPClient
    
    private let urlRequestBuilder = URLRequestBuilder()
    
    private let cancellationToken = RequestCancellationToken()
    
    // MARK: - Initializer
    
    init(networkClient: HTTPClient, category: String) {
        self.networkClient = networkClient
        self.category = category
    }
    
    // MARK: - Requests
    
    func getArticles(success: @escaping ([VisibleArticle]) -> Void, failure: @escaping (() -> Void)) {
        let myurl: String = "https://api.nytimes.com/svc/topstories/v2/\(category).json?api-key=jGNtGsUTozACEcGEtLEW8xQKAa95gPqb"
            
            guard let url = URL(string: myurl) else {return}
            
            let urlRequest = URLRequest(url: url)
            
            networkClient
                .executeTask(urlRequest, cancelledBy: cancellationToken)
                .processCodableResponse { (response: HTTPResponse<ATopStories>) in
                    switch response.result {
                    case .success(let response):
                        let item: [VisibleArticle] = response.results.map { VisibleArticle(category: $0.section,
                                                                                           title: $0.title,
                                                                                           author: $0.byline,
                                                                                           subTitle: $0.abstract,
                                                                                           urlArticle: $0.url,
                                                                                           date: $0.updatedDate,
                                                                                           smallPictureUrl: $0.multimedia.filter { $0.format.rawValue.contains("Standard Thumbnail") }.map { $0.url }.first ?? "https://static01.nyt.com/images/2019/10/14/business/00CHINA-DNA1/00CHINA-DNA1-thumbStandard.jpg",
                                                                                           bigPictureUrl: $0.multimedia.filter { $0.format.rawValue.contains("mediumThreeByTwo210") }.map { $0.url }.first ?? "https://static01.nyt.com/images/2019/10/14/business/00CHINA-DNA1/00CHINA-DNA1-mediumThreeByTwo210.jpg") }
                    success(item)
                    case .failure(_):
                        failure()
                    }
            }
        }
    }


