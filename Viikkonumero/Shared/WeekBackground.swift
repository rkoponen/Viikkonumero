import SwiftUI

/// A soft accent-colored gradient fading into the system background.
struct WeekBackground: View {
    var body: some View {
        LinearGradient(
            colors: [.accentColor.opacity(0.18), .clear],
            startPoint: .top,
            endPoint: .bottom
        )
        .background(.background)
    }
}

#Preview {
    WeekBackground()
}
