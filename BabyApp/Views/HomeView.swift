import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                BabySwitchView()
                QuickRecordView()
                TodaySummaryView()
                Spacer()
            }
            .padding()
            .navigationTitle("今日")
        }
    }
}

struct TodaySummaryView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("今日摘要")
                .font(.headline)
            Text("喝奶 4 次 · 420 ml")
            Text("睡眠 5 小时")
            Text("便便 1 次 · 外出 1 次")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
    }
}
