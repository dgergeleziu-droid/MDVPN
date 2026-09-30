import Foundation
import Combine

@MainActor
final class VPNManager: ObservableObject {

    @Published var state: VPNState = .disconnected
    @Published var selectedServer: Server = Server.sample[2] // Finland по умолчанию
    @Published var servers: [Server] = Server.sample

    private var task: Task<Void, Never>?

    func toggle() {
        switch state {
        case .disconnected, .error: connect()
        case .connected:            disconnect()
        default: break
        }
    }

    private func connect() {
        state = .connecting
        task?.cancel()
        task = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 1_800_000_000)
            guard let self, !Task.isCancelled else { return }
            self.state = .connected
        }
    }

    private func disconnect() {
        state = .disconnecting
        task?.cancel()
        task = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 600_000_000)
            guard let self, !Task.isCancelled else { return }
            self.state = .disconnected
        }
    }

    func select(_ server: Server) {
        selectedServer = server
        if state == .connected {
            disconnect()
            Task {
                try? await Task.sleep(nanoseconds: 800_000_000)
                connect()
            }
        }
    }
}
