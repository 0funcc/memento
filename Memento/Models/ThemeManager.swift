import SwiftUI
import Combine

class ThemeManager: ObservableObject {
    @Published var appTheme: String = UserDefaults.standard.string(forKey: "appTheme") ?? AppTheme.system.rawValue {
        didSet { UserDefaults.standard.set(appTheme, forKey: "appTheme") }
    }
    
    @Published var colorTheme: String = UserDefaults.standard.string(forKey: "colorTheme") ?? "default" {
        didSet { UserDefaults.standard.set(colorTheme, forKey: "colorTheme") }
    }
    
    func currentBackground(for colorScheme: ColorScheme) -> Color {
        let isDark = appTheme == AppTheme.dark.rawValue ||
                    (appTheme == AppTheme.system.rawValue && colorScheme == .dark)
        
        return isDark
            ? AppColors.themes[colorTheme]?.dark ?? .black
            : AppColors.themes[colorTheme]?.light ?? .white
    }
}
