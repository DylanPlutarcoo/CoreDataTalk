//
//  CoreDataTestVM.swift
//  CoreDataTest
//
//  Created by userext on 21/08/23.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject {
    @Published var savedTasks: [TaskEntity] = []
    private let context = CoreDataStack.shared.container.viewContext
    
    
    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        do {
            savedTasks = try CoreDataStack.shared.container.viewContext.fetch(request)
        } catch let error {
            print("error fetching. \(error)")
            
        }
    }
    
    func addTask(title: String) {
        let newTask = TaskEntity(context: CoreDataStack.shared.container.viewContext)
        newTask.title = title
        newTask.isCompleted = false
        CoreDataStack.shared.saveContext()
        fetchTasks()
    }
    
    func deleteTasks(at offsets: IndexSet) {
            offsets.forEach { index in
                let task = savedTasks[index]
                context.delete(task)
            }
            CoreDataStack.shared.saveContext()
            fetchTasks()
        }
    
    func toggleTaskCompletion(task: TaskEntity) {
        task.isCompleted.toggle()
        CoreDataStack.shared.saveContext()
        fetchTasks()
    }
}

