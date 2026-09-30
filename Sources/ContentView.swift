import SwiftUI

struct ContentView: View {

    @EnvironmentObject var vpn: VPNManager

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Palette.background, Palette.backgroundHi],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {

                // ─── ЛОГО M&D — ПО ЦЕНТРУ СВЕРХУ ────────────────────
                MDLogo(isActive: vpn.state.isOn)
                    .padding(.top, 24)

                Spacer().frame(height: 20)

                // ─── Статус ────────────────────────────────────────
                StatusBadge(state: vpn.state)

                Spacer().frame(height: 8)

                Text(vpn.state.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(Palette.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                // ─── Кнопка Connect ────────────────────────────────
                ConnectButton(state: vpn.state) {
                    vpn.toggle()
                }

                Spacer()

                // ─── Сервер ────────────────────────────────────────
                ServerRow(server: vpn.selectedServer, isActive: vpn.state.isOn)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
            }
        }
    }
}

// ─── Строка выбранного сервера ───────────────────────────────

struct ServerRow: View {

    let server: Server
    let isActive: Bool

    var body: some View {
        HStack(spacing: 12) {
            Text(server.flag)
                .font(.system(size: 26))

            VStack(alignment: .leading, spacing: 2) {
                Text(server.country)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Palette.textPrimary)
                Text(server.city)
                    .font(.system(size: 12))
                    .foregroundColor(Palette.textSecondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                HStack(spacing: 4) {
                    Circle()
                        .fill(Palette.green)
                        .frame(width: 6, height: 6)
                    Text("\(server.ping) ms")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Palette.green)
                }
                Text("Fastest")
                    .font(.system(size: 10))
                    .foregroundColor(Palette.textDim)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Palette.textDim)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Palette.surface)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Palette.stroke, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
