//
//  ArticleViewModel.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class ArticleViewModel {
    
    // MARK: - Properties
    
    var article: VisibleArticle
    
    private weak var delegate: ArticleViewModelDelegate?
    
    private let repository: ArticleRepositoryType
    
    // MARK: - Initializer
    
    init(article: VisibleArticle, delegate: ArticleViewModelDelegate?, repository: ArticleRepositoryType) {
        self.article = article
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    var visibleArticle: ((VisibleArticle) -> Void)?
    
    var isFavorite: ((Bool) -> Void)?
    
    func viewDidLoad() {
        visibleArticle?(article)
        
        repository.checkIfFavorite(title: article.title) { state in
            self.isFavorite?(state)
        }
    }
    
    // MARK: - Inputs
    
    func clickedOnFavorite() {
        repository.checkIfFavorite(title: article.title) { (favoriteState) in
            switch favoriteState {
            case true:
                repository.removeFavorite(title: article.title)
                isFavorite?(false)
            case false:
                repository.addToFavorite(article: article)
                isFavorite?(true)
            }
        }
    }
    
    func openWebView() {
        delegate?.showFullArticle(for: article)
    }
}

