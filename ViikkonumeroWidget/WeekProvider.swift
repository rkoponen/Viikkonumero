import WidgetKit

struct WeekProvider: TimelineProvider {
    func placeholder(in context: Context) -> WeekEntry {
        WeekEntry(date: .now)
    }

    func getSnapshot(in context: Context, completion: @escaping (WeekEntry) -> Void) {
        completion(WeekEntry(date: .now))
    }

    /// One entry per midnight for the next week, so the date rolls over on time.
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeekEntry>) -> Void) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)

        var entries = [WeekEntry(date: .now)]
        for offset in 1...7 {
            if let midnight = calendar.date(byAdding: .day, value: offset, to: today) {
                entries.append(WeekEntry(date: midnight))
            }
        }
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}
