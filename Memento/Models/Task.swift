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
