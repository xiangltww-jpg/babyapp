import SwiftUI
import Charts

struct TrendPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Int
}

struct TrendChartView: View {
    let title: String
    let points: [TrendPoint]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Chart(points) { point in
                LineMark(
                    x: .value("日期", point.date),
                    y: .value("次数", point.value)
                )
            }
            .frame(height: 180)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
    }
}
