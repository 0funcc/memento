//
//  TaskDetailView.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 06/03/2026.
//

import SwiftUI
import SwiftData

struct TaskDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var task: Task
    
    var body: some View {
        Form {
            Section("Task Name") {
                TextField("Name", text: $task.taskName)
            }
            
            Section("Description") {
                TextField("Description", text: Binding(
                    get: { task.taskDescription ?? "" },
                    set: { task.taskDescription = $0.isEmpty ? nil : $0 }
                ), axis: .vertical)
                .lineLimit(4...8)
            }
            
            Section("Due Date") {
                Toggle("Has Due Date", isOn: Binding(
                    get: { task.taskDueDate != nil },
                    set: { task.taskDueDate = $0 ? Date() : nil }
                ))
                
                if task.taskDueDate != nil {
                    DatePicker("Date", selection: Binding(
                        get: { task.taskDueDate ?? Date() },
                        set: { task.taskDueDate = $0 }
                    ), displayedComponents: .date)
                }
            }
            
            Section {
                Toggle("Completed", isOn: $task.isCompleted)
            }
        }
        .navigationTitle(task.taskName.isEmpty ? "New Task" : task.taskName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button(role: .destructive) {
                    modelContext.delete(task)
                    try? modelContext.save()
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var card: Task = .init(taskName: "Test Task", taskDescription: "Test Description", taskDueDate: nil, isCompleted: false)
    TaskDetailView(task: card)
}
