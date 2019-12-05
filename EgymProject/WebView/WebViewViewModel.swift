//
//  WebViewViewModel.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 05/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class WebViewViewModel {
    
    // MARK: - Properties
    
    private var article: VisibleArticle
    
    private let repository: WebViewRepositoryType
    
    // MARK: - Initializer
    
    init(article: VisibleArticle, repository: WebViewRepositoryType) {
        self.article = article
        self.repository = repository
    }
    // MARK: - Outputs
    
    var address: ((String) -> Void)?
    
    var isFavorite: ((Bool) -> Void)?
    
    func viewDidLoad() {
        address?(article.urlArticle)
        
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

}
