import SwiftUI

struct ConnectButton: View {

    let state: VPNState
    let action: () -> Void

    @State private var pulse = false

    private var ring: Color {
        state.isOn ? Palette.green : Palette.green
    }

    private var iconName: String {
        switch state {
        case .connected:  return "shield.fill"
        case .connecting,
             .disconnecting: return "shield.lefthalf.filled"
        default:          return "power"
        }
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                // Внешнее пульсирующее кольцо
                Circle()
                    .stroke(ring.opacity(0.18), lineWidth: 2)
                    .frame(width: 290, height: 290)
                    .scaleEffect(pulse ? 1.06 : 1.0)
                    .opacity(state.isOn ? 1 : 0.4)

                Circle()
                    .stroke(ring.opacity(0.10), lineWidth: 2)
                    .frame(width: 250, height: 250)

                // Свечение по центру
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                ring.opacity(state.isOn ? 0.45 : 0.20),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: 150
                        )
                    )
                    .frame(width: 260, height: 260)

                // Основной диск
                Circle()
                    .fill(
                        LinearGradient(
                            colors: state.isOn
                                ? [Palette.green, Palette.greenDark]
                                : [Palette.surfaceHi, Palette.surface],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 190, height: 190)
                    .overlay(
                        Circle().stroke(
                            state.isOn
                                ? Palette.greenLight.opacity(0.8)
                                : Palette.stroke,
                            lineWidth: 1.5
                        )
                    )
                    .shadow(
                        color: state.isOn
                            ? Palette.green.opacity(0.55)
                            : Color.black.opacity(0.35),
                        radius: state.isOn ? 28 : 14,
                        y: 8
                    )

                // Иконка
                VStack(spacing: 6) {
                    Image(systemName: iconName)
                        .font(.system(size: 52, weight: .regular))
                        .foregroundColor(
                            state.isOn ? Color.white : Palette.green
                        )
                        .opacity(state.isBusy ? 0.6 : 1.0)

                    Text(state.isOn ? "TAP TO STOP" : "TAP TO CONNECT")
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .tracking(1)
                        .foregroundColor(
                            state.isOn ? Color.white.opacity(0.85) : Palette.textDim
                        )
                }
            }
            .frame(width: 300, height: 300)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .disabled(state.isBusy)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }
}
