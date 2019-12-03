//
//  ListingViewModel.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

struct VisibleArticle: Equatable {
    let category: String
    let title: String
    let author: String
    let subTitle: String
    let urlArticle: String
    let date: String
    let smallPictureUrl: String
    let bigPictureUrl: String
}

final class ListingViewModel {
    
    // MARK: - Properties
    
    private let repository: ListingRepositoryType
    
    private weak var delegate: ListingViewModelDelegate?
    
    private var source: String
    
    private var articles: [VisibleArticle] = [] {
        didSet {
            print(articles)
        }
    }
    
    // MARK: - Initializer
    
    init(repository: ListingRepositoryType,delegate: ListingViewModelDelegate?, source: String) {
        self.repository = repository
        self.source = source
    }
    // MARK: - Outputs
    
    func viewDidLoad() {
         refresh()
    }
    
    private func refresh() {
        repository.getArticles(for: source, success: { (articles) in
            print(articles)
            self.articles = articles
        }, failure: { [weak self] in
            self?.delegate?.shouldDisplayAlert(for: .requestError)
        })
    }
    
    // MARK: - Inputs
    
}
