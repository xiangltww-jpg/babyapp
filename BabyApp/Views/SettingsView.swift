import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            List {
                Section("账户") {
                    Text(appState.currentUser?.email ?? "未登录")
                    Button("退出登录") {
                        Task { try? await appState.environment.authService.signOut() }
                    }
                }

                Section("宝宝") {
                    Button("管理宝宝") {
                        // TODO: open baby management
                    }
                }
            }
            .navigationTitle("设置")
        }
    }
}
