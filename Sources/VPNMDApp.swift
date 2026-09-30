import SwiftUI

@main
struct VPNMDApp: App {
    @StateObject private var vpn = VPNManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vpn)
                .preferredColorScheme(.dark)
        }
    }
}
