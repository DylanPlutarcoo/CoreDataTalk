import SwiftUI
import CoreData

struct TaskView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var newTask = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Insira a tarefa", text: $newTask, onCommit: {
                    viewModel.addTask(title: newTask)
                    newTask = ""
                })
                .padding(.horizontal, 20)
                .padding(.top, 20)
                List {
                    ForEach(viewModel.savedTasks) { task in
                        HStack {
                            Button(action: {
                                viewModel.toggleTaskCompletion(task: task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                            Text(task.title ?? "")
                                .strikethrough(task.isCompleted)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTasks)
                }
                .navigationBarTitle("All Tasks")
            }
        }
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: TaskViewModel())
    }
}
