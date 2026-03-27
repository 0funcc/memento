//
//  RoutineCardView.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 23/03/2026.
//

import SwiftUI
import SwiftData

struct RoutineCardView: View {
    let routine: Routine
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            
            // Icon
            Text(routine.routineIcon)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text(routine.routineName)
                    .font(.headline)
                
                if let description = routine.routineDescription {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                
                // Task count badge
                Label("\(routine.tasks.count) tasks", systemImage: "checklist")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .padding(.top, 2)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
    }
}

#Preview {
    let routine = Routine(routineIcon: "🌅", routineName: "Morning Routine", routineDescription: "Start the day with focus and energy")
    
    RoutineCardView(routine: routine)
}
