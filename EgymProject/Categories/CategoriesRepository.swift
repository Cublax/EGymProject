//
//  CategoriesRepository.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 04/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol CategoriesRepositoryType {
    func getCategories(callback: @escaping ([String: String]) -> Void)
}

final class CategoriesRepository: CategoriesRepositoryType {
    
    private let categories: [String: String] = ["Arts": "arts",
                                                "Automobiles": "automobiles",
                                                "Books": "books",
                                                "Business": "business",
                                                "Fashion": "fashion",
                                                "Food": "food",
                                                "Health": "health",
                                                "Home": "home",
                                                "Insider": "insider",
                                                "Magazine": "magazine",
                                                "Movies": "movies",
                                                "National": "national",
                                                "New York Region": "nyregion",
                                                "Obituaries": "obituaries",
                                                "Opinion": "opinion",
                                                "Politics": "politics",
                                                "Real Estate": "realestate",
                                                "Science": "science",
                                                "Sports": "sports",
                                                "Sunday Review": "sundayreview",
                                                "Technology": "technology",
                                                "Theather": "theater",
                                                "T Magazine": "tmagazine",
                                                "Travel": "travel",
                                                "The Upshot": "upshot",
                                                "World": "world"]
    
    func getCategories(callback: @escaping ([String : String]) -> Void) {
        callback(categories)
    }
}
