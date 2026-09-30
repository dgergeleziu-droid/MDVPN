// MDVPNApp.swift
import SwiftUI

@main
struct MDVPNApp: App {
    @StateObject private var vpn = VPNViewModel()

    var body: some Scene {
        WindowGroup {
            MainVPNView()
                .environmentObject(vpn)
                .preferredColorScheme(.dark)
        }
    }
}
