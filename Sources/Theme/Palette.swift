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

/// Фирменная палитра M&D — зелёный + серый
enum Palette {

    // ─── Зелёный (главный акцент) ────────────────────────────
    static let green        = Color(hex: "#22C55E")   // основной зелёный
    static let greenDark    = Color(hex: "#16A34A")   // для градиента
    static let greenLight   = Color(hex: "#4ADE80")   // подсветка
    static let greenGlow    = Color(hex: "#22C55E")   // свечение

    // ─── Серый (фон и поверхности) ───────────────────────────
    static let background   = Color(hex: "#1A1D21")   // тёмно-серый фон
    static let backgroundHi = Color(hex: "#23272E")   // чуть светлее
    static let surface      = Color(hex: "#2A2F36")   // карточки
    static let surfaceHi    = Color(hex: "#343A43")   // акцентные карточки
    static let stroke       = Color(hex: "#3A4048")   // границы

    // ─── Текст ───────────────────────────────────────────────
    static let textPrimary  = Color(hex: "#F1F5F9")
    static let textSecondary = Color(hex: "#A1A9B3")
    static let textDim      = Color(hex: "#6B7280")

    // ─── Статусы ─────────────────────────────────────────────
    static let danger       = Color(hex: "#EF4444")
    static let warning      = Color(hex: "#F59E0B")

    // ─── Логотип M&D ─────────────────────────────────────────
    /// Когда приложение в состоянии "не подключено" — лого серое
    static let logoGray     = Color(hex: "#7B8493")
    /// Когда подключено — лого зелёное
    static let logoGreen    = Color(hex: "#22C55E")
}
