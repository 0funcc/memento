//
//  SettingsView.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 14/03/2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("userName") private var userName: String = ""
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $userName)
                    .textContentType(.givenName)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
