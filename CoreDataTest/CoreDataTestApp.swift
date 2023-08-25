//
//  CoreDataTestApp.swift
//  CoreDataTest
//
//  Created by userext on 21/08/23.
//

import SwiftUI

@main
struct CoreDataTestApp: App {

    var body: some Scene {
        WindowGroup {
            TaskView(viewModel: TaskViewModel(stack: CoreDataStack()))
                .environment(\.managedObjectContext, CoreDataStack.shared.container.viewContext)
        }
    }
}
