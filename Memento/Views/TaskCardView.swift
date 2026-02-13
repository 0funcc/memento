//
//  TaskCardView.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 13/02/2026.
//

import SwiftUI

struct TaskCardView: View {
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Button(action: { task.isCompleted.toggle() }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle.dotted")
                    .contentTransition(.symbolEffect(.replace))
            }
            
            VStack(alignment: .leading) {
                Text(task.taskName)
                    .font(.headline)
                
                HStack {
                    Text(task.taskDescription ?? "")
                        .font(.caption)
                    
                    Spacer()
                    
                    if let due = task.taskDueDate {
                        Text(due.formatted(.dateTime.year().month().day()))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    } else {
                        Text("")
                    }
                }
            }
        }
        .padding()
        .glassEffect()
        .listRowSeparator(.hidden)
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 60)) {
    @Previewable @State var card: Task = .init(taskName: "Test Task", taskDescription: nil, taskDueDate: Date(), isCompleted: false)
    TaskCardView(task: $card)
}

