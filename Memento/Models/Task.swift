//
//  TaskModel.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 13/02/2026.
//

import SwiftData
import SwiftUI

@Model
class Task {
    var taskName: String
    var taskDescription: String?
    var taskDueDate: Date?
    var isCompleted: Bool = false
    
    init(taskName: String, taskDescription: String?, taskDueDate: Date?, isCompleted: Bool) {
        self.taskName = taskName
        self.taskDescription = taskDescription?.isEmpty == true ? nil : taskDescription
        self.taskDueDate = taskDueDate
        self.isCompleted = isCompleted
    }
}

extension Task {
    static func todayPredicate() -> Predicate<Task> {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfTomorrow = calendar.date(byAdding: .day, value: 1, to: startOfToday)!

        return #Predicate<Task> { task in
            // Only tasks with a non-nil due date that is within today
            if let dueDate = task.taskDueDate {
                return dueDate >= startOfToday && dueDate < startOfTomorrow
            } else {
                // Decide how to treat tasks with no due date
                return false
            }
        }
    }
}
