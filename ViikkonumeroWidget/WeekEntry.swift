import WidgetKit

struct WeekEntry: TimelineEntry {
    let date: Date
    var week: WeekInfo { WeekInfo(date: date) }
}
