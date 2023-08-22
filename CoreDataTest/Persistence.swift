//
//  Persistence.swift
//  CoreDataTest
//
//  Created by userext on 21/08/23.
//

import CoreData


struct CoreDataStack {
    static let shared = CoreDataStack()

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

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//
//    let container: NSPersistentContainer
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "CoreDataTest")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
//}
//
//
// enum StorageType {
//    case persistent, inMemory
// }
//
// class CoreDataStack {
//    public static let shared = CoreDataStack(.persistent)
//    public static let inMemory = CoreDataStack(.inMemory)
//    private static let modelName: String = "LoveMyPet"
//    private var persistentContainer: NSPersistentContainer
//    init(_ storageType: StorageType = .persistent) {
//        self.persistentContainer = NSPersistentContainer(name: CoreDataStack.modelName)
//        if storageType == .inMemory {
//            let description = NSPersistentStoreDescription()
//            description.type = NSInMemoryStoreType
//            self.persistentContainer.persistentStoreDescriptions = [description]
//        }
//        self.persistentContainer.loadPersistentStores { (storeDescription, error) in
//            if let error = error as NSError? {
//                print("CoreDataStack Error - Unresolved error (error), (error.userInfo)")
//            }
//        }
//        var context: NSManagedObjectContext = {
//            return self.persistentContainer.viewContext
//        }()
//        func save() {
//            let context = persistentContainer.viewContext
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    let nserror = error as NSError
//                    fatalError("Unresolved error (nserror)")
//                }
//            }
//        }
//    }
// }
//    func saveEdit() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror)")
//            }
//        }
//    }
//            let description = NSPersistentStoreDescription()
//            description.type = NSInMemoryStoreType
//            self.persistentContainer.persistentStoreDescriptions = [description]

