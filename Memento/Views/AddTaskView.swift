//
//  AddTaskView.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 15/02/2026.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    @State private var taskName = ""
    @State private var taskDescription = ""
    @State private var taskDueDate: Date?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var hasReminder = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Task Information") {
                    TextField("Task Name", text: $taskName)
                    TextField("Task Description", text: $taskDescription)
                }
                
                Section("Schedule") {
                    Toggle("Reminder", isOn: $hasReminder.animation())
                    
                    if hasReminder {
                        DatePicker(
                            "Due Date",
                            selection: Binding(
                                get: { taskDueDate ?? Date() },
                                set: { taskDueDate = $0 }
                            ),
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(.compact)
                    }
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let finalDescription = taskDescription
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                        let taskDescValue: String? = finalDescription.isEmpty ? nil : finalDescription
                        let dueDateValue: Date? = hasReminder ? (taskDueDate ?? Date()) : nil
                        
                        let newTask = Task(
                            taskName: taskName,
                            taskDescription: taskDescValue,
                            taskDueDate: dueDateValue,
                            isCompleted: false
                        )
                        
                        modelContext.insert(newTask)
                        dismiss()
                    }
                    .disabled(taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView()
}
