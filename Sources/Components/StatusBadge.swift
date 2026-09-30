import SwiftUI

struct StatusBadge: View {

    let state: VPNState

    private var color: Color {
        switch state {
        case .connected:  return Palette.green
        case .connecting,
             .disconnecting: return Palette.warning
        case .error:      return Palette.danger
        default:          return Palette.textDim
        }
    }

    private var icon: String {
        switch state {
        case .connected:  return "checkmark.shield.fill"
        case .connecting,
             .disconnecting: return "arrow.triangle.2.circlepath"
        case .error:      return "exclamationmark.triangle.fill"
        default:          return "shield.slash"
        }
    }

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 11, weight: .bold))
            Text(state.title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .tracking(1.2)
        }
        .foregroundColor(color)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(color.opacity(0.14))
        .clipShape(Capsule())
        .overlay(Capsule().stroke(color.opacity(0.35), lineWidth: 1))
    }
}
