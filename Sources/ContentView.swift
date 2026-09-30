import SwiftUI

struct ContentView: View {

    @EnvironmentObject var vpn: VPNManager

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Фон
                LinearGradient(
                    colors: [Palette.background, Palette.backgroundSoft],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {

                    // ─── Верхняя полоса с логотипом M&D ─────────────
                    HStack {
                        Spacer()
                        MDLogo()
                            .padding(.trailing, 20)
                            .padding(.top, 6)
                    }

                    Spacer()

                    // ─── Статус ────────────────────────────────────
                    VStack(spacing: 8) {
                        Text(vpn.state.title)
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .foregroundColor(Palette.textPrimary)

                        Text(vpn.state.subtitle)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Palette.textSecondary)
                    }

                    Spacer().frame(height: 40)

                    // ─── Кнопка Connect ────────────────────────────
                    ConnectButton(state: vpn.state) {
                        vpn.toggle()
                    }

                    Spacer().frame(height: 32)

                    // ─── Выбранный сервер ──────────────────────────
                    HStack(spacing: 10) {
                        Text(vpn.selectedServer.flag)
                            .font(.system(size: 22))
                        VStack(alignment: .leading, spacing: 2) {
                            Text(vpn.selectedServer.country)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Palette.textPrimary)
                            Text(vpn.selectedServer.city)
                                .font(.system(size: 12))
                                .foregroundColor(Palette.textSecondary)
                        }
                        Spacer()
                        Text("\(vpn.selectedServer.ping) ms")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Palette.success)
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(Palette.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 24)

                    Spacer()
                }
            }
        }
    }
}
