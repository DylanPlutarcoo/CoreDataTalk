//
//  Persistence.swift
//  CoreDataTest
//
//  Created by userext on 21/08/23.
//

import CoreData


struct CoreDataStack {
    static let shared = CoreDataStack()
    
    var context: NSManagedObjectContext { self.container.viewContext }

    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func saveContext() -> Bool {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                let nsError = error as NSError
                return false
            }
        } else {
            return false
        }
    }
}
