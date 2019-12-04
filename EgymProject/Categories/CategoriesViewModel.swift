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
    
    private let repository: CategoriesRepository
    
    private weak var delegate: CategoriesViewModelDelegate?
    
    // MARK: - Initializer
    
    init(repository: CategoriesRepository,
         delegate: CategoriesViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    // MARK: - Outputs
    
    var visibleCategories: (([String]) -> Void)?
    
    func viewDidLoad() {
        visibleCategories?(getKeyArray(for: repository.categories))
    }
    
    // MARK: - Inputs
    
    private func getKeyArray(for dictionnary: [String: String]) -> [String] {
        var keys = [String]()
        for _ in dictionnary {
            keys = [String](repository.categories.keys)
        }
        return keys
    }
    
    func didSelectCategory(with category: String) {
        guard let value = repository.categories[category] else {return}
        
        delegate?.didSelectCategory(category: value)
    }
    
}
