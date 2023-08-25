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
                        HStack {Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                .onTapGesture {
                                    viewModel.toggleTask(task: task)
                                }
                            Text(task.title ?? "")
                            Spacer()
                            
                            NavigationLink(
                                destination: EditTaskView(task: task, action: {
                                    viewModel.fetchTasks()
                                }),
                                label: {
                                }
                            )
                        }
                    }
                    .onDelete(perform: viewModel.deleteTasks)
                }
                .navigationBarTitle("All Tasks")
                .listStyle(PlainListStyle())
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
