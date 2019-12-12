//
//  CategoriesViewModel.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class CategoriesViewModel {
    
    // MARK: - Properties
    
    private var dictionary = [String: String]() {
        didSet {
            visibleCategories?([String](dictionary.keys))
        }
    }
    
    private let repository: CategoriesRepositoryType
    
    private weak var delegate: CategoriesViewModelDelegate?
    
    // MARK: - Initializer
    
    init(repository: CategoriesRepositoryType,
         delegate: CategoriesViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    // MARK: - Outputs
    
    var visibleCategories: (([String]) -> Void)?
    
    func viewDidLoad() {
        repository.getCategories { dictionary in
            self.dictionary = dictionary
        }
    }
    
    // MARK: - Inputs
    
    func didSelectCategory(with category: String) {
        guard let value = dictionary[category] else {return}
        
        delegate?.didSelectCategory(category: value)
    }
}
