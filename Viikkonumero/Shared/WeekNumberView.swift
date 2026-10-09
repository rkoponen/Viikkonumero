import SwiftUI

/// Minimal display of the week number, optionally with the days of the week beneath it.
struct WeekNumberView: View {
    let week: WeekInfo
    /// Whether the days the week spans are shown beneath the number, e.g. "5.10.–11.10.".
    var showsDayRange = true
    /// Whether the word "Week" is shown above the number.
    var showsLabel = true

    @Environment(\.calendar) private var calendar

    var body: some View {
        VStack(spacing: 4) {
            if showsLabel {
                Text("Week")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
            }

            Text(week.weekNumber, format: .number)
                .font(.system(size: 120, weight: .semibold, design: .rounded))
                .minimumScaleFactor(0.3)
                .lineLimit(1)
                .accessibilityLabel(showsLabel ? Text(week.weekNumber, format: .number) : Text("Week \(week.weekNumber)"))

            if showsDayRange {
                dayRangeText
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .accessibilityElement(children: .combine)
    }

    @ViewBuilder
    private var dayRangeText: some View {
        let style = Date.FormatStyle.dateTime.day().month(.defaultDigits)
        if endsInDifferentYear {
            Text("\(week.weekStart, format: style)–\(week.weekEnd, format: style.year())")
        } else {
            Text("\(week.weekStart, format: style)–\(week.weekEnd, format: style)")
        }
    }

    /// Whether the week ends in a different year than today, in which case the year is shown.
    private var endsInDifferentYear: Bool {
        calendar.component(.year, from: week.weekEnd) != calendar.component(.year, from: .now)
    }
}

#Preview {
    WeekNumberView(week: WeekInfo())
        .padding()
}
