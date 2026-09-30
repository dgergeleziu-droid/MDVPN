import SwiftUI

/// Сплэш-экран — большой логотип M&D по центру,
/// зелёное свечение вокруг, плавный fade-out.
struct SplashView: View {

    let onFinish: () -> Void

    @State private var scale: CGFloat = 0.7
    @State private var opacity: Double = 0
    @State private var glow: Double = 0.4

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Palette.background, Palette.backgroundHi],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            // Мягкое зелёное свечение за логотипом
            Circle()
                .fill(Palette.green.opacity(glow * 0.35))
                .frame(width: 320, height: 320)
                .blur(radius: 90)

            VStack(spacing: 18) {
                Text("M&D")
                    .font(.system(size: 84, weight: .heavy, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Palette.greenLight, Palette.green, Palette.greenDark],
                            startPoint: .top, endPoint: .bottom
                        )
                    )
                    .shadow(color: Palette.green.opacity(0.55), radius: 24)

                Text("SECURE VPN")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .tracking(4)
                    .foregroundColor(Palette.textSecondary)
            }
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                scale = 1.0
                opacity = 1.0
            }
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                glow = 0.9
            }

            // Авто-переход через 2 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                onFinish()
            }
        }
    }
}
