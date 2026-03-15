//
//  MementoApp.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 06/02/2026.
//

import SwiftUI
import SwiftData

@main
struct MementoApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(themeManager)
                .preferredColorScheme(
                    themeManager.appTheme == AppTheme.light.rawValue ? .light :
                    themeManager.appTheme == AppTheme.dark.rawValue ? .dark : nil
                )
        }
        .modelContainer(for: Task.self)
    }
}
