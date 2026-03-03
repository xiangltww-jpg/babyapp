import Foundation

@MainActor
final class ReminderViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []

    private let firestore: FirestoreService
    private let notificationService: NotificationService

    init(firestore: FirestoreService, notificationService: NotificationService) {
        self.firestore = firestore
        self.notificationService = notificationService
    }

    func loadReminders(babyId: String) async {
        do {
            reminders = try await firestore.fetchReminders(babyId: babyId)
        } catch {
            reminders = []
        }
    }

    func upsertReminder(_ reminder: Reminder) async {
        do {
            try await firestore.upsertReminder(reminder)
            if reminder.enabled {
                try await notificationService.scheduleReminder(reminder)
            } else {
                await notificationService.cancelReminder(reminderId: reminder.id)
            }
        } catch {
            // TODO: handle error
        }
    }
}
