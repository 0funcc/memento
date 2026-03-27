import SwiftUI
import SwiftData

struct RoutineCardView: View {
    let routine: Routine
    
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            // Icon
            Text(routine.routineIcon)
                .font(.title2)
                .frame(width: 52, height: 52)
                .background(routine.color.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(routine.color.opacity(0.4), lineWidth: 1)
                )
            
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
            
            Spacer(minLength: 0)
        }
        .padding(16)
        .glassEffect(
            routine.routineColor != nil
                ? .regular.tint(routine.color)
                : .regular,
            in: RoundedRectangle(cornerRadius: 24)
        )
    }
}

#Preview {
    VStack(spacing: 12) {
        // With color
        RoutineCardView(routine: {
            let r = Routine(routineIcon: "🌅", routineName: "Morning Routine", routineDescription: "Start the day with focus and energy", routineColor: "FF6B6B")
            return r
        }())
        
        // With different color
        RoutineCardView(routine: {
            let r = Routine(routineIcon: "💪", routineName: "Workout", routineDescription: "Strength and cardio session", routineColor: "4ECDC4")
            return r
        }())
        
        // Default (no color)
        RoutineCardView(routine: {
            let r = Routine(routineIcon: "📚", routineName: "Evening Reading", routineDescription: nil)
            return r
        }())
    }
    .padding()
}
