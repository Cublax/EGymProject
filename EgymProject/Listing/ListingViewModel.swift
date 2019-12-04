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
    
    private var articles: [VisibleArticle] = [] {
        didSet {
            visibleArticles?(self.articles)
        }
    }
    
    // MARK: - Initializer
    
    init(repository: ListingRepositoryType,delegate: ListingViewModelDelegate?) {
        self.repository = repository
    }
    // MARK: - Outputs
    
     var visibleArticles: (([VisibleArticle]) -> Void)?
    
    func viewDidLoad() {
         refresh()
    }
    
    private func refresh() {
        repository.getArticles(success: { (articles) in
            self.articles = articles
        }, failure: { [weak self] in
            self?.delegate?.shouldDisplayAlert(for: .requestError)
        })
    }
    
    // MARK: - Inputs
    
    func didSelectArticle(with article: VisibleArticle) {
        delegate?.didSelectArticle(article: article)
    }
}
