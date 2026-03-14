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
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    task.isCompleted.toggle()
                }
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle.dotted")
                    .contentTransition(.symbolEffect(.replace))
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(task.taskName)
                        .font(.headline)
                        .lineLimit(1)
                    
                    if hasDueDate {
                        Spacer()
                        Text(task.taskDueDate!.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                    }
                }
                
                if hasDescription {
                    Text(task.taskDescription ?? "")
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }

            Spacer(minLength: 0)
        }
        .padding()
        .glassEffect(.clear)
        .listRowSeparator(.hidden)
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 60)) {
    @Previewable @State var card: Task = .init(taskName: "Test Task", taskDescription: "Test Description", taskDueDate: nil, isCompleted: false)
    TaskCardView(task: card)
}
