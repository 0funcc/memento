import SwiftUI

struct SettingsView: View {
    @AppStorage("userName") private var userName: String = ""
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $userName)
                    .textContentType(.givenName)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
            }
            
            Section("Appearance") {
                Picker("Theme", selection: $themeManager.appTheme) {
                    Text("System").tag(AppTheme.system.rawValue)
                    Text("Light").tag(AppTheme.light.rawValue)
                    Text("Dark").tag(AppTheme.dark.rawValue)
                }
                
                Picker("Color", selection: $themeManager.colorTheme) {
                    Text("Default").tag("default")
                    Text("Ocean").tag("ocean")
                    Text("Sunset").tag("sunset")
                    Text("Pink").tag("pink")
                    Text("Mint").tag("mint")
                }
            }
        }
        .navigationTitle("Settings")
        .scrollContentBackground(.hidden)
        .background(themeManager.currentBackground(for: colorScheme).ignoresSafeArea())
    }
}

#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
}
