import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var vm = ReminderViewModel(
        firestore: AppEnvironment.shared.firestoreService,
        notificationService: AppEnvironment.shared.notificationService
    )

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.reminders) { reminder in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(reminder.type.titleCN)
                            Text(reminder.mode.titleCN)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Toggle("", isOn: binding(for: reminder))
                            .labelsHidden()
                    }
                }
            }
            .navigationTitle("提醒")
            .toolbar {
                Button("新增") {
                    // TODO: add reminder sheet
                }
            }
            .task {
                guard let babyId = appState.selectedBaby?.id else { return }
                await vm.loadReminders(babyId: babyId)
            }
        }
    }

    private func binding(for reminder: Reminder) -> Binding<Bool> {
        Binding(
            get: { reminder.enabled },
            set: { newValue in
                var updated = reminder
                updated.enabled = newValue
                Task { await vm.upsertReminder(updated) }
            }
        )
    }
}
