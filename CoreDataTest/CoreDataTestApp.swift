//
//  CoreDataTestApp.swift
//  CoreDataTest
//
//  Created by userext on 21/08/23.
//

import SwiftUI

@main
struct CoreDataTestApp: App {
    let coreData = CoreDataStack.shared

    var body: some Scene {
        WindowGroup {
            TaskView(viewModel: TaskViewModel())
                .environment(\.managedObjectContext, CoreDataStack.shared.container.viewContext)
        }
    }
}
