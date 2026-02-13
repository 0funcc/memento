//
//  MainView.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 13/02/2026.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }
            
            AllView()
                .tabItem {
                    Label("All", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    MainView()
}
