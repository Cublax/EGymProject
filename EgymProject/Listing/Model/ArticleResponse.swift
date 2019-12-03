//
//  ArticleResponse.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 02/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

// MARK: - ATopStories
struct ATopStories: Codable {
    let results: [AResult]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - AResult
struct AResult: Codable {
    let section: String
    let title: String
    let abstract: String
    let url: String
    let byline: String
    let updatedDate: String
    let multimedia: [AMultimedia]

    enum CodingKeys: String, CodingKey {
        case section, title, abstract, url, byline
        case updatedDate = "updated_date"
        case multimedia
    }
}


// MARK: - AMultimedia
struct AMultimedia: Codable {
    let url: String
    let format: AFormat
}

enum AFormat: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case normal = "Normal"
    case standardThumbnail = "Standard Thumbnail"
    case superJumbo = "superJumbo"
    case thumbLarge = "thumbLarge"
}
