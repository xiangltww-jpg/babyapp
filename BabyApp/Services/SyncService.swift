import Foundation

protocol SyncService {
    func startSync(for babyId: String)
    func stopSync()
}

final class DefaultSyncService: SyncService {
    func startSync(for babyId: String) {
        // TODO: start listener for events/reminders
    }

    func stopSync() {
        // TODO: stop listeners
    }
}
