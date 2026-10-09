import SwiftUI
import WidgetKit

struct WeekWidgetView: View {
    let entry: WeekEntry
    @Environment(\.widgetFamily) private var family

    var body: some View {
        switch family {
        case .accessoryCircular:
            VStack(spacing: 0) {
                Text("Week")
                    .font(.caption2)
                    .textCase(.uppercase)
                Text(entry.week.weekNumber, format: .number)
                    .font(.system(.title, design: .rounded, weight: .semibold))
                    .minimumScaleFactor(0.5)
            }
        case .accessoryRectangular:
            Text("Week \(entry.week.weekNumber)")
                .font(.title2.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
        case .accessoryInline:
            Text("Week \(entry.week.weekNumber)")
        default:
            WeekNumberView(week: entry.week, showsDayRange: false)
        }
    }
}
