import SwiftUI

/// A horizontally scrolling carousel of weeks, starting on the current week.
/// The neighbouring weeks peek in from the sides to show that the view can be swiped.
struct WeekCarouselView: View {
    private let cardWidthFraction = 0.45

    @State private var weeks = WeekInfo.weeks()
    @State private var currentWeekID = WeekInfo().id
    @State private var selection: Date? = WeekInfo().id
    @State private var loadedOn = Date.now
    @State private var containerWidth = 0.0
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.calendar) private var calendar

    private var cardWidth: Double { containerWidth * cardWidthFraction }
    private var sideMargin: Double { (containerWidth - cardWidth) / 2 }

    /// Whether the visible week is before the current one, so the current week lies ahead.
    private var currentWeekIsAhead: Bool {
        guard let selection else { return false }
        return selection < currentWeekID
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(weeks) { week in
                    WeekNumberView(week: week, showsLabel: false)
                        .frame(width: cardWidth)
                        .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.3)
                                .scaleEffect(phase.isIdentity ? 1 : 0.55)
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, sideMargin, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $selection)
        .scrollIndicators(.hidden)
        .onGeometryChange(for: Double.self) { $0.size.width } action: { containerWidth = $0 }
        .overlay(alignment: .bottom) {
            if selection != currentWeekID {
                currentWeekButton
                    .padding(.bottom)
                    .transition(.opacity)
            }
        }
        .animation(.default, value: selection == currentWeekID)
        .onChange(of: scenePhase) {
            if scenePhase == .active, !calendar.isDateInToday(loadedOn) {
                weeks = WeekInfo.weeks()
                currentWeekID = WeekInfo().id
                selection = currentWeekID
                loadedOn = .now
            }
        }
    }

    private var currentWeekButton: some View {
        Button("Back to this week", systemImage: currentWeekIsAhead ? "chevron.right" : "chevron.left") {
            withAnimation {
                selection = currentWeekID
            }
        }
        .labelStyle(.iconOnly)
        .buttonStyle(.glass)
        .buttonBorderShape(.circle)
        .controlSize(.large)
    }
}

#Preview {
    WeekCarouselView()
}
