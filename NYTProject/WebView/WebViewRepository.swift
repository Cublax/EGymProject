//
//  WebViewRepository.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 05/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation
import CoreData

protocol WebViewRepositoryType: class {
    func addToFavorite(article: VisibleArticle)
    func checkIfFavorite(title: String, completion: (Bool) -> Void)
    func removeFavorite(title: String)
}

final class WebViewRepository: WebViewRepositoryType {
    
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func checkIfFavorite(title: String, completion: (Bool) -> Void) {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ArticleEntity.title, ascending: true)]
        
        guard let articles = try? stack.context.fetch(request) else { print("error") ; return }
        
        if articles == [] {completion(false); return }
        
        completion(true)
    }
    
    func addToFavorite(article: VisibleArticle) {
        let articleObject = ArticleEntity(context: stack.context)
        articleObject.category = article.category
        articleObject.title = article.title
        articleObject.author = article.title
        articleObject.subTitle = article.subTitle
        articleObject.urlArticle = article.urlArticle
        articleObject.smallPictureUrl = article.smallPictureUrl
        articleObject.bigPictureUrl = article.bigPictureUrl
        stack.saveContext()
    }
    
    func removeFavorite(title: String) {
        
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let object = try stack.context.fetch(request)
            if !object.isEmpty {
                stack.context.delete(object[0])
                stack.saveContext()
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
