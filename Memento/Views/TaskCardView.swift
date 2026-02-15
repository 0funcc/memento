//
//  TaskCardView.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 13/02/2026.
//

import SwiftUI

struct TaskCardView: View {
    @Bindable var task: Task
    
    private var hasDescription: Bool {
        !(task.taskDescription?.isEmpty ?? true)
    }

    private var hasDueDate: Bool {
        task.taskDueDate != nil
    }
    
    var body: some View {
        HStack {
            Button(action: { task.isCompleted.toggle() }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle.dotted")
                    .contentTransition(.symbolEffect(.replace))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if hasDescription && hasDueDate {                    Text(task.taskName)
                        .font(.headline)
                    
                    HStack {
                        Text(task.taskDescription ?? "")
                            .font(.subheadline)
                        Spacer()
                        Text(task.taskDueDate!.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                    }
                }
                else if hasDescription {
                    Text(task.taskName)
                        .font(.headline)
                    Text(task.taskDescription ?? "")
                        .font(.subheadline)
                }
                else if hasDueDate {                    HStack {
                        Text(task.taskName)
                            .font(.headline)
                        Spacer()
                        Text(task.taskDueDate!.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                    }
                }
                else {
                    Text(task.taskName)
                        .font(.headline)
                }
            }

            Spacer(minLength: 0)
        }
        .padding()
        .glassEffect()
        .listRowSeparator(.hidden)
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 60)) {
    @Previewable @State var card: Task = .init(taskName: "Test Task", taskDescription: nil, taskDueDate: nil, isCompleted: false)
    TaskCardView(task: card)
}
