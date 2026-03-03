import Foundation

struct ReportSummary: Equatable {
    var totalCountByType: [EventType: Int]
    var totalAmountMl: Int
    var totalSleepMinutes: Int
    var dailySeries: [Date: [EventType: Int]]
}

protocol ReportService {
    func weeklyReport(events: [Event], start: Date, end: Date) -> ReportSummary
    func monthlyReport(events: [Event], start: Date, end: Date) -> ReportSummary
}

final class DefaultReportService: ReportService {
    func weeklyReport(events: [Event], start: Date, end: Date) -> ReportSummary {
        buildReport(events: events, start: start, end: end)
    }

    func monthlyReport(events: [Event], start: Date, end: Date) -> ReportSummary {
        buildReport(events: events, start: start, end: end)
    }

    private func buildReport(events: [Event], start: Date, end: Date) -> ReportSummary {
        var totalCountByType: [EventType: Int] = [:]
        var totalAmountMl = 0
        var totalSleepMinutes = 0
        var dailySeries: [Date: [EventType: Int]] = [:]
        let calendar = Calendar.current

        for event in events {
            totalCountByType[event.type, default: 0] += 1
            if event.type == .milk { totalAmountMl += event.amountMl ?? 0 }
            if event.type == .sleep { totalSleepMinutes += event.durationMinutes ?? 0 }

            let day = calendar.startOfDay(for: event.startAt)
            var dayMap = dailySeries[day, default: [:]]
            dayMap[event.type, default: 0] += 1
            dailySeries[day] = dayMap
        }

        return ReportSummary(
            totalCountByType: totalCountByType,
            totalAmountMl: totalAmountMl,
            totalSleepMinutes: totalSleepMinutes,
            dailySeries: dailySeries
        )
    }
}
