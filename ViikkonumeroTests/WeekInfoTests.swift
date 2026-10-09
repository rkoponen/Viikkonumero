import Foundation
import Testing
@testable import Viikkonumero

@MainActor
struct WeekInfoTests {
    private let calendar = Calendar(identifier: .iso8601)

    private func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 12))!
    }

    private func components(_ date: Date) -> DateComponents {
        calendar.dateComponents([.year, .month, .day], from: date)
    }

    @Test func weekNumberForOrdinaryDate() {
        #expect(WeekInfo(date: date(2026, 10, 8)).weekNumber == 41)
    }

    @Test func weekNumberAtYearBoundaries() {
        // 2026 has 53 ISO weeks, so its last week runs into January 2027.
        #expect(WeekInfo(date: date(2026, 12, 28)).weekNumber == 53)
        #expect(WeekInfo(date: date(2027, 1, 3)).weekNumber == 53)
        #expect(WeekInfo(date: date(2027, 1, 4)).weekNumber == 1)
        // Late December 2025 already belongs to week 1 of 2026.
        #expect(WeekInfo(date: date(2025, 12, 29)).weekNumber == 1)
    }

    @Test func weekRunsFromMondayToSunday() {
        let week = WeekInfo(date: date(2026, 10, 8))
        #expect(components(week.weekStart) == DateComponents(year: 2026, month: 10, day: 5))
        #expect(components(week.weekEnd) == DateComponents(year: 2026, month: 10, day: 11))
        #expect(calendar.component(.weekday, from: week.weekStart) == 2)
        #expect(calendar.component(.weekday, from: week.weekEnd) == 1)
    }

    @Test func weekRangeCrossesMonthAndYear() {
        let week = WeekInfo(date: date(2026, 12, 30))
        #expect(components(week.weekStart) == DateComponents(year: 2026, month: 12, day: 28))
        #expect(components(week.weekEnd) == DateComponents(year: 2027, month: 1, day: 3))
    }

    @Test func everyDayOfAWeekSharesTheSameID() {
        let ids = (5...11).map { WeekInfo(date: date(2026, 10, $0)).id }
        #expect(Set(ids).count == 1)
    }

    @Test func weeksListIsCenteredAndConsecutive() {
        let now = date(2026, 10, 8)
        let weeks = WeekInfo.weeks(around: now, radius: 26)

        #expect(weeks.count == 53)
        #expect(weeks[26].id == WeekInfo(date: now).id)

        for (previous, next) in zip(weeks, weeks.dropFirst()) {
            let days = calendar.dateComponents([.day], from: previous.weekStart, to: next.weekStart).day
            #expect(days == 7)
        }
    }
}
