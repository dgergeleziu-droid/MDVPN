import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

enum Palette {
    /// Фон приложения — глубокий тёмный с холодным оттенком
    static let background     = Color(hex: "#0A0E14")
    static let backgroundSoft = Color(hex: "#121822")
    static let surface        = Color(hex: "#1A2230")
    static let surfaceHigh    = Color(hex: "#232D3D")

    /// Основные акценты
    static let accent         = Color(hex: "#4A9EFF")
    static let accentSoft     = Color(hex: "#7BC0FF")
    static let success        = Color(hex: "#3DDC84")
    static let danger         = Color(hex: "#FF5A5F")
    static let warning        = Color(hex: "#FFB84D")

    /// Текст
    static let textPrimary    = Color(hex: "#F5F7FA")
    static let textSecondary  = Color(hex: "#98A2B3")
    static let textDim        = Color(hex: "#59616B")

    /// Логотип M&D — приглушённый серо-графитовый
    static let logoText       = Color(hex: "#59616B")
}
