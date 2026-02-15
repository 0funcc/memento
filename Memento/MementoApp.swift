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
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Task.self)
    }
}
