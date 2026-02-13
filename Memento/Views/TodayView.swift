// displays tasks that are due today

import SwiftUI

struct TodayView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            }
            .navigationTitle("Today")
        }
    }
}

#Preview {
    TodayView()
}
