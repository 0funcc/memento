import SwiftUI

struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    @Environment(\.dismiss) private var dismiss
    
    let emojis: [String] = [
        "⭐️", "🔥", "💪", "🧘", "📚", "🎯", "🌅", "🌙", "🏃", "🍎",
        "💤", "🧹", "💊", "🎨", "🎵", "💻", "✍️", "🧠", "🚴", "🏋️",
        "🥗", "☕️", "🧘‍♂️", "📝", "🌿", "💧", "🛁", "🧺", "📖", "🎧",
        "🏊", "🧗", "🤸", "🛌", "🌞", "❄️", "🦷", "👟", "🎒", "🌍"
    ]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(emojis, id: \.self) { emoji in
                    Button {
                        selectedEmoji = emoji
                        dismiss()
                    } label: {
                        Text(emoji)
                            .font(.largeTitle)
                            .padding(8)
                            .background(
                                selectedEmoji == emoji
                                    ? Color.accentColor.opacity(0.2)
                                    : Color.clear
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
            .navigationTitle("Pick an Icon")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
