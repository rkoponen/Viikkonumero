import SwiftUI
import WidgetKit

struct WeekWidget: Widget {
    let kind = "WeekWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeekProvider()) { entry in
            WeekWidgetView(entry: entry)
                .containerBackground(for: .widget) { WeekBackground() }
        }
        .configurationDisplayName("Week Number")
        .description("Shows the current week number.")
        .supportedFamilies(Self.families)
    }

    private static var families: [WidgetFamily] {
        [.systemSmall, .accessoryCircular, .accessoryRectangular, .accessoryInline]
    }
}
