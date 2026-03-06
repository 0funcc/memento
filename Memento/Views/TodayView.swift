import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(filter: Task.todayPredicate()) var tasks: [Task]
    
    @State private var isAddTaskPresented: Bool = false
    
    var body: some View {
        VStack {
            if tasks.isEmpty {
                Text("No tasks")
                    .padding()
            } else {
                List {
                    ForEach(tasks) { task in
                        ZStack {
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                Color.clear
                            }
                            TaskCardView(task: task)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .background(
            Image("bg")
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationTitle("Today")
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
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context after deletion: \(error)")
        }
    }
}

#Preview {
    TodayView()
}
