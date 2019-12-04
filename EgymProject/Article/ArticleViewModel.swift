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
    
    // MARK: - Initializer
    
    init(article: VisibleArticle, delegate: ArticleViewModelDelegate?) {
        self.article = article
        self.delegate = delegate
    }
    // MARK: - Outputs
    
     var visibleArticle: ((VisibleArticle) -> Void)?
    
    func viewDidLoad() {
        visibleArticle?(article)
    }
    
    // MARK: - Inputs
    
    func openWebView() {
     //   delega
    }
    
}
