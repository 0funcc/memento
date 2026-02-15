// displays tasks that are due today

import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(filter: Task.todayPredicate()) var tasks: [Task]
    
    @State var isAddTaskPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if tasks.isEmpty {
                    Text("No tasks")
                } else {
                    List {
                        ForEach(tasks) { task in
                            TaskCardView(task: task)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem {
                    Button(action: { isAddTaskPresented = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddTaskPresented) {
                AddTaskView()
            }
            
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { tasks[$0] }
        for task in itemsToDelete {
            modelContext.delete(task)
        }
        do {
            try modelContext.save()
        } catch {
            // Handle save error appropriately in a real app, perhaps with an alert
            print("Failed to save context after deletion: \(error)")
        }
    }
}

#Preview {
    TodayView()
}

