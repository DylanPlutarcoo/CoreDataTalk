//
//  EditTaskView.swift
//  CoreDataTest
//
//  Created by userext on 23/08/23.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var task: TaskEntity
    @StateObject var viewModel = TaskViewModel()
    @State private var editedTitle = ""
    var action: () -> Void
    
    var body: some View {
        VStack {
            TextField("\(task.title ?? "")",text: $editedTitle, onCommit: {
                CoreDataStack.shared.saveContext()
                presentationMode.wrappedValue.dismiss()
            })
                .padding()
            Spacer()
            Button("Salvar") {
                task.title = editedTitle
                CoreDataStack.shared.saveContext()
                presentationMode.wrappedValue.dismiss()
                action()
            }
            .padding()
        }
        .navigationBarTitle("Edit Task")
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: TaskViewModel())
    }
}
