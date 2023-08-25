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
    var editingTask: TaskEntity?
    private let stack: CoreDataStack
    
    
    init(stack: CoreDataStack = .shared) {
        self.stack = stack
        fetchTasks()
    }
    
    func addTask(title: String) {
        let newTask = TaskEntity(context: stack.context)
        newTask.title = title
        newTask.isCompleted = false
        stack.saveContext()
        fetchTasks()
    }
    
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        do {
            savedTasks = try stack.context.fetch(request)
        } catch let error {
            print("error fetching. \(error)")
        }
    }
    
    func editTask(task: TaskEntity, newTitle: String) {
        task.title = newTitle
        CoreDataStack.shared.saveContext()
        fetchTasks()
    }

    
    func deleteTasks(at offsets: IndexSet) {
        var indexremove: Int?
        offsets.forEach { index in
            let task = savedTasks[index]
            stack.context.delete(task)
            indexremove = index
        }
        if stack.saveContext() {
            if let index = indexremove{
                savedTasks.remove(at: index)
            }
        }
    }
    func toggleTask(task: TaskEntity) {
        task.isCompleted.toggle()
        CoreDataStack.shared.saveContext()
        fetchTasks()
    }
}

