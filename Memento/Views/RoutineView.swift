import SwiftUI
import SwiftData

struct RoutineView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var isAddRoutinePresented: Bool = false
    
    @Query private var routines: [Routine]
    
    var body: some View {
        ZStack {
            themeManager.currentBackground(for: colorScheme)
                .ignoresSafeArea()
            
            if routines.isEmpty {
                VStack(alignment: .leading) {
                    Text("🏜️")
                        .font(.largeTitle)
                    Text("So empty...")
                        .font(.headline)
                        .bold()
                    Text("Add a new routine")
                    
                    Button(action: { isAddRoutinePresented = true }) {
                        Text("New Routine")
                    }
                    .buttonStyle(.glassProminent)
                }
                .sheet(isPresented: $isAddRoutinePresented) {
                    AddRoutineView()
                }
            } else {
                VStack {
                    ForEach(routines) { routine in
                        NavigationLink(destination: RoutineDetailView()) {
                            RoutineCardView(routine: routine)
                        }
                    }
                }
            }
        }
        .navigationTitle("Routines")
    }
}

private func makePreviewContainer() -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Routine.self, configurations: config)
    
    let routine1 = Routine(routineIcon: "☀️", routineName: "Morning Routine", routineDescription: "Start the day right")
    let routine2 = Routine(routineIcon: "🌙", routineName: "Evening Routine", routineDescription: "Wind down")
    let routine3 = Routine(routineIcon: "💪", routineName: "Workout", routineDescription: nil)
    
    container.mainContext.insert(routine1)
    container.mainContext.insert(routine2)
    container.mainContext.insert(routine3)
    
    return container
}

#Preview {
    RoutineView()
        .modelContainer(makePreviewContainer())
        .environmentObject(ThemeManager())
}
