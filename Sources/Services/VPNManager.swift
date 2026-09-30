import Foundation
import Combine

/// Менеджер состояния VPN.
/// Пока — визуальная имитация. Реальный туннель добавим через
/// NetworkExtension (Packet Tunnel Provider) на втором этапе.
@MainActor
final class VPNManager: ObservableObject {

    @Published var state: VPNState = .disconnected
    @Published var selectedServer: Server = Server.sample[0]
    @Published var servers: [Server] = Server.sample

    private var connectTask: Task<Void, Never>?

    func toggle() {
        switch state {
        case .disconnected, .error:
            connect()
        case .connected:
            disconnect()
        default:
            break
        }
    }

    private func connect() {
        state = .connecting
        connectTask?.cancel()
        connectTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 2_200_000_000)
            guard let self, !Task.isCancelled else { return }
            self.state = .connected
        }
    }

    private func disconnect() {
        state = .disconnecting
        connectTask?.cancel()
        connectTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 700_000_000)
            guard let self, !Task.isCancelled else { return }
            self.state = .disconnected
        }
    }

    func select(_ server: Server) {
        selectedServer = server
        if state == .connected {
            // переподключение к новому серверу
            disconnect()
            Task {
                try? await Task.sleep(nanoseconds: 800_000_000)
                connect()
            }
        }
    }
}
