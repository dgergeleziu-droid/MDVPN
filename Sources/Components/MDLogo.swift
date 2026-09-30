import SwiftUI

/// Логотип M&D — верхний правый угол.
/// Требования:
/// - только текст "M&D"
/// - цвет #59616B, opacity 0.75
/// - размер 14 pt
/// - без рамок, без фона, без иконки
struct MDLogo: View {
    var body: some View {
        Text("M&D")
            .font(.system(size: 14, weight: .medium, design: .rounded))
            .foregroundColor(Palette.logoText)
            .opacity(0.75)
            .kerning(0.5)
            .accessibilityLabel("M&D")
    }
}
