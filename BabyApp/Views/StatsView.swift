import SwiftUI

struct StatsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var vm = StatsViewModel(
        firestore: AppEnvironment.shared.firestoreService,
        reportService: AppEnvironment.shared.reportService
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let weekly = vm.weeklySummary {
                    ReportSummaryCard(title: "本周汇总", summary: weekly)
                }
                if let monthly = vm.monthlySummary {
                    ReportSummaryCard(title: "本月汇总", summary: monthly)
                }

                TrendChartView(title: "喝奶趋势", points: demoPoints())
                TrendChartView(title: "睡眠趋势", points: demoPoints())
            }
            .padding()
        }
        .navigationTitle("统计")
        .task {
            guard let babyId = appState.selectedBaby?.id else { return }
            await vm.loadReports(babyId: babyId)
        }
    }

    private func demoPoints() -> [TrendPoint] {
        let calendar = Calendar.current
        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: -offset, to: Date()) ?? Date()
            return TrendPoint(date: date, value: Int.random(in: 1...6))
        }.reversed()
    }
}

struct ReportSummaryCard: View {
    let title: String
    let summary: ReportSummary

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text("总次数：\(summary.totalCountByType.values.reduce(0, +))")
            Text("喝奶总量：\(summary.totalAmountMl) ml")
            Text("睡眠总时长：\(summary.totalSleepMinutes) 分钟")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
    }
}
