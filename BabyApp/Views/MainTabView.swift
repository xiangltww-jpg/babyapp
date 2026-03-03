import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("首页", systemImage: "house") }
            TimelineView()
                .tabItem { Label("时间线", systemImage: "list.bullet") }
            StatsView()
                .tabItem { Label("统计", systemImage: "chart.xyaxis.line") }
            ReminderView()
                .tabItem { Label("提醒", systemImage: "bell") }
            SettingsView()
                .tabItem { Label("设置", systemImage: "gearshape") }
        }
    }
}
