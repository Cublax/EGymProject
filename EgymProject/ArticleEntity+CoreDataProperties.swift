//
//  ArticleEntity+CoreDataProperties.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 04/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var bigPictureUrl: String?
    @NSManaged public var category: String?
    @NSManaged public var smallPictureUrl: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var title: String?
    @NSManaged public var urlArticle: String?

}
