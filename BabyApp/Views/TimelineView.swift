import SwiftUI

struct TimelineView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var vm = EventListViewModel(firestore: AppEnvironment.shared.firestoreService)

    var body: some View {
        NavigationStack {
            List(vm.events) { event in
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.type.titleCN)
                        .font(.headline)
                    Text(event.startAt.formatted())
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    if let note = event.note {
                        Text(note)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("时间线")
            .task {
                guard let babyId = appState.selectedBaby?.id else { return }
                let now = Date()
                let from = Calendar.current.date(byAdding: .day, value: -7, to: now) ?? now
                await vm.loadEvents(babyId: babyId, from: from, to: now)
            }
        }
    }
}
