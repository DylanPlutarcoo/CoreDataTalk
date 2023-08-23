import SwiftUI
import CoreData

struct TaskView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var newTask = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Insira a tarefa", text: $newTask, onCommit: {
                    viewModel.addTask(title: newTask)
                    newTask = ""
                })
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                List {
                    ForEach(viewModel.savedTasks) { task in
                        HStack {
                            Button(action: {
                                viewModel.toggleTask(task: task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                            Text(task.title ?? "")
                                .strikethrough(task.isCompleted)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTasks)
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("All Tasks")
                .padding(.top, 40)
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: TaskViewModel())
    }
}
