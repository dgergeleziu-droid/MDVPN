import SwiftUI

/// Логотип M&D — крупный, по центру, сразу видно.
/// Меняет цвет в зависимости от состояния: серый → зелёный.
struct MDLogo: View {

    let isActive: Bool

    var body: some View {
        VStack(spacing: 6) {
            Text("M&D")
                .font(.system(size: 46, weight: .heavy, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: isActive
                            ? [Palette.greenLight, Palette.green, Palette.greenDark]
                            : [Palette.logoGray, Palette.textDim],
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .shadow(
                    color: (isActive ? Palette.green : Color.clear).opacity(0.5),
                    radius: 14
                )
                .kerning(1)
                .animation(.easeInOut(duration: 0.4), value: isActive)

            Text("SECURE VPN")
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .tracking(3.5)
                .foregroundColor(Palette.textDim)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("M and D VPN")
    }
}
