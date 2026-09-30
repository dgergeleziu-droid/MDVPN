import SwiftUI

@main
struct VPNMDApp: App {
    @StateObject private var vpn = VPNManager()
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showSplash = false
                        }
                    }
                    .transition(.opacity)
                } else {
                    ContentView()
                        .environmentObject(vpn)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
