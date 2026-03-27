//
//  Routine.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 23/03/2026.
//

import SwiftData
import SwiftUI

@Model
class Routine {
    var routineIcon: String
    var routineName: String
    var routineDescription: String?
    var routineColor: String?
    var createdAt: Date
    
    @Relationship(deleteRule: .nullify, inverse: \Task.routines)
    var tasks: [Task] = []
    
    // Computed property for easy use in views
    var color: Color {
        guard let hex = routineColor else { return .primary }
        return Color(hex: hex)
    }
    
    init(routineIcon: String, routineName: String, routineDescription: String? = nil, routineColor: String? = nil) {
        self.routineIcon = routineIcon
        self.routineName = routineName
        self.routineDescription = routineDescription?.isEmpty == true ? nil : routineDescription
        self.routineColor = routineColor
        self.createdAt = Date()
    }
}
