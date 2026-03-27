import SwiftUI
import SwiftData

struct AddRoutineView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var showEmojiPicker = false
    @State private var routineName = ""
    @State private var routineDescription = ""
    @State private var routineIcon = "⭐️"
    @State private var routineColor: Color = .primary
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Routine Information") {
                    TextField("Routine Name", text: $routineName)
                    TextField("Routine Description", text: $routineDescription)
                }
                
                Section("Appearance") {
                    Button {
                        showEmojiPicker = true
                    } label: {
                        HStack {
                            Text("Icon")
                                .foregroundStyle(.primary)
                            Spacer()
                            Text(routineIcon)
                                .font(.title2)
                                .frame(width: 44, height: 44)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                    ColorPicker("Routine Color", selection: $routineColor)
                }
            }
            .scrollContentBackground(.hidden)
            .background(themeManager.currentBackground(for: colorScheme).ignoresSafeArea())
            .navigationTitle("Add Routine")
            .sheet(isPresented: $showEmojiPicker) { // 👈 moved outside Form
                EmojiPickerView(selectedEmoji: $routineIcon)
                    .presentationDetents([.fraction(0.6), .large]) // 👈 more breathing room
                    .presentationDragIndicator(.visible)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let finalDescription = routineDescription
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        let newRoutine = Routine(
                            routineIcon: routineIcon,
                            routineName: routineName.trimmingCharacters(in: .whitespacesAndNewlines),
                            routineDescription: finalDescription.isEmpty ? nil : finalDescription,
                            routineColor: routineColor.toHex()
                        )
                        
                        modelContext.insert(newRoutine)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                    .disabled(routineName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddRoutineView()
        .environmentObject(ThemeManager())
}
