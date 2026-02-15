//
//  MainView.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 13/02/2026.
//

import SwiftUI

struct MainView: View {
    let day = Date.todayDayNumber
    
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "\(day)")
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
