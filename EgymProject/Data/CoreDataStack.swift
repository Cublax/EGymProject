//
//  CoreDataStack.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 04/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataStackType: class {
    var persistentContainer: NSPersistentContainer { get set }
    func saveContext()
}

final class CoreDataStack {

    private let container: NSPersistentContainer

    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(modelName: String, type: String = NSSQLiteStoreType) {
        let description = NSPersistentStoreDescription()
        description.type = type
        container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions.append(description)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error) , \(error.userInfo)")
            }
        }
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
