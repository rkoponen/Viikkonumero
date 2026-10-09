import Foundation

/// The ISO 8601 week (weeks start on Monday) that contains a given date.
struct WeekInfo: Equatable, Identifiable, Sendable {
    /// The date this value was created for; the widget shows it as "today".
    let date: Date
    let weekNumber: Int
    /// Monday of the week.
    let weekStart: Date
    /// Sunday of the week.
    let weekEnd: Date

    var id: Date { weekStart }

    init(date: Date = .now) {
        let calendar = Calendar(identifier: .iso8601)
        self.date = date
        self.weekNumber = calendar.component(.weekOfYear, from: date)
        let start = calendar.dateInterval(of: .weekOfYear, for: date)?.start ?? date
        self.weekStart = start
        self.weekEnd = calendar.date(byAdding: .day, value: 6, to: start) ?? start
    }

    /// Number of weeks shown before and after the current one.
    static let defaultRadius = 26

    /// Consecutive weeks centered on the week containing `date`.
    static func weeks(around date: Date = .now, radius: Int = defaultRadius) -> [WeekInfo] {
        let calendar = Calendar(identifier: .iso8601)
        return (-radius...radius).compactMap { offset in
            calendar.date(byAdding: .weekOfYear, value: offset, to: date).map { WeekInfo(date: $0) }
        }
    }
}
