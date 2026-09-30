import Foundation

enum VPNState: Equatable {
    case disconnected
    case connecting
    case connected
    case disconnecting
    case error(String)

    var title: String {
        switch self {
        case .disconnected:  return "Not Connected"
        case .connecting:    return "Connecting"
        case .connected:     return "Protected"
        case .disconnecting: return "Disconnecting"
        case .error:         return "Error"
        }
    }

    var subtitle: String {
        switch self {
        case .disconnected:  return "Tap the button to protect your connection"
        case .connecting:    return "Finding fastest server..."
        case .connected:     return "Your traffic is encrypted end-to-end"
        case .disconnecting: return "Please wait"
        case .error(let m):  return m
        }
    }

    var isBusy: Bool { self == .connecting || self == .disconnecting }
    var isOn: Bool   { self == .connected }
}

struct Server: Identifiable, Equatable {
    let id = UUID()
    let country: String
    let city: String
    let flag: String
    let ping: Int

    static let sample: [Server] = [
        Server(country: "Netherlands", city: "Amsterdam", flag: "🇳🇱", ping: 24),
        Server(country: "Germany",     city: "Frankfurt", flag: "🇩🇪", ping: 31),
        Server(country: "Finland",     city: "Helsinki",  flag: "🇫🇮", ping: 18),
        Server(country: "USA",         city: "New York",  flag: "🇺🇸", ping: 112),
        Server(country: "Japan",       city: "Tokyo",     flag: "🇯🇵", ping: 187),
    ]
}
