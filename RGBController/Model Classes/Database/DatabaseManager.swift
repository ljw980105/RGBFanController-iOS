//
//  DatabaseManager.swift
//  RGBController
//
//  Created by Jing Wei Li on 3/14/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import CoreData

class DatabaseManager: NSObject {
    
    private static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RGBDatabase")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    
    static var context = DatabaseManager.persistentContainer.viewContext
    
    static func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}

