import SwiftUI

struct AppColors {
    static let themes: [String: (light: Color, dark: Color)] = [
        "default": (Color(hex: "F5F5F0"), Color(.systemBackground)),
        "ocean":   (Color(hex: "E0F4FF"), Color(hex: "0A1628")),
        "sunset":  (Color(hex: "FFF3E0"), Color(hex: "1C1008")),
        "pink":    (Color(hex: "FFE4EE"), Color(hex: "1C0F14")),
        "mint":    (Color(hex: "E8F5F0"), Color(hex: "0A1C16")),
    ]
}
