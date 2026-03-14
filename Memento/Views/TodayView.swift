import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(filter: Task.todayPredicate()) var tasks: [Task]
    
    @State private var isAddTaskPresented: Bool = false
    
    @AppStorage("userName") private var userName: String = ""
    
    var incompleteTasks: [Task] { tasks.filter { !$0.isCompleted } }
    var completedTasks: [Task] { tasks.filter { $0.isCompleted } }
    
    var body: some View {
        VStack {
            if tasks.isEmpty {
                Text("No tasks")
                    .padding()
            } else {
                List {
                    Section {
                        ForEach(incompleteTasks) { task in
                            TaskCardView(task: task)
                                .background {
                                    NavigationLink(value: task) { EmptyView() }
                                        .opacity(0)
                                }
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                        .onDelete { offsets in
                            deleteItems(at: offsets, from: incompleteTasks)
                        }
                    } header: {
                        Text("Todo")
                            .font(.caption)
                    }
                    
                    if !completedTasks.isEmpty {
                        Section {
                            ForEach(completedTasks) { task in
                                TaskCardView(task: task)
                                    .background {
                                        NavigationLink(value: task) { EmptyView() }
                                            .opacity(0)
                                    }
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                            }
                            .onDelete { offsets in
                                deleteItems(at: offsets, from: completedTasks)
                            }
                        } header: {
                            Text("Completed")
                                .font(.caption)
                        }
                    }
                }
                .listStyle(.plain)
                .animation(.easeInOut(duration: 0.3), value: incompleteTasks.map(\.isCompleted))
                .animation(.easeInOut(duration: 0.3), value: completedTasks.count)
                .scrollContentBackground(.hidden)
                .navigationDestination(for: Task.self) { task in
                    TaskDetailView(task: task)
                }
            }
        }
        .navigationTitle("\(greetingText())")
        .toolbar {
            ToolbarItem {
                Button {
                    isAddTaskPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddTaskPresented) {
            AddTaskView()
        }
    }
    
    private func deleteItems(at offsets: IndexSet, from source: [Task]) {
        for index in offsets {
            modelContext.delete(source[index])
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context after deletion: \(error)")
        }
    }
    
    private func greetingText() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let displayName = userName.isEmpty ? "User" : userName
        
        let greeting: String
        switch hour {
        case 5..<12:
            greeting = "Good morning"
        case 12..<17:
            greeting = "Good afternoon"
        case 17..<21:
            greeting = "Good evening"
        default:
            greeting = "Good night"
        }
        
        return "\(greeting), \(displayName)"
    }
}

#Preview {
    TodayView()
}
