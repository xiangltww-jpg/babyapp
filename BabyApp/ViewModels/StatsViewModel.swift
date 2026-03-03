import Foundation

@MainActor
final class StatsViewModel: ObservableObject {
    @Published var weeklySummary: ReportSummary?
    @Published var monthlySummary: ReportSummary?

    private let firestore: FirestoreService
    private let reportService: ReportService

    init(firestore: FirestoreService, reportService: ReportService) {
        self.firestore = firestore
        self.reportService = reportService
    }

    func loadReports(babyId: String) async {
        let calendar = Calendar.current
        let now = Date()

        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) ?? now
        let weekEnd = calendar.date(byAdding: .day, value: 7, to: weekStart) ?? now

        let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: now)) ?? now
        let monthEnd = calendar.date(byAdding: .month, value: 1, to: monthStart) ?? now

        do {
            let weekEvents = try await firestore.fetchEvents(babyId: babyId, from: weekStart, to: weekEnd)
            weeklySummary = reportService.weeklyReport(events: weekEvents, start: weekStart, end: weekEnd)

            let monthEvents = try await firestore.fetchEvents(babyId: babyId, from: monthStart, to: monthEnd)
            monthlySummary = reportService.monthlyReport(events: monthEvents, start: monthStart, end: monthEnd)
        } catch {
            weeklySummary = nil
            monthlySummary = nil
        }
    }
}
