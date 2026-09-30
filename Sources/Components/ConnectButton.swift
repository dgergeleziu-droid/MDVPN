import SwiftUI

struct ConnectButton: View {

    let state: VPNState
    let action: () -> Void

    @State private var pulse = false

    private var ringColor: Color {
        state.isOn ? Palette.success : Palette.accent
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                // Пульсирующее кольцо вокруг (только Connected / Connecting)
                if state.isOn || state == .connecting {
                    Circle()
                        .stroke(ringColor.opacity(0.25), lineWidth: 2)
                        .frame(width: 260, height: 260)
                        .scaleEffect(pulse ? 1.08 : 1.0)
                        .opacity(pulse ? 0.35 : 0.75)
                }

                // Основной диск
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                state.isOn ? Palette.success.opacity(0.35)
                                           : Palette.accent.opacity(0.35),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: 140
                        )
                    )
                    .frame(width: 240, height: 240)

                Circle()
                    .fill(Palette.surfaceHigh)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Circle()
                            .stroke(ringColor.opacity(0.6), lineWidth: 2)
                    )
                    .shadow(color: ringColor.opacity(0.35), radius: 30, y: 12)

                // Иконка питания
                Image(systemName: "power")
                    .font(.system(size: 64, weight: .light))
                    .foregroundColor(ringColor)
                    .opacity(state.isBusy ? 0.6 : 1.0)
            }
            .frame(width: 280, height: 280)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .disabled(state.isBusy)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }
}
