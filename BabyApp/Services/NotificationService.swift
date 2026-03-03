import Foundation
import UserNotifications

protocol NotificationService {
    func requestPermission() async throws
    func scheduleReminder(_ reminder: Reminder) async throws
    func cancelReminder(reminderId: String) async
}

final class UserNotificationService: NotificationService {
    func requestPermission() async throws {
        let center = UNUserNotificationCenter.current()
        _ = try await center.requestAuthorization(options: [.alert, .sound, .badge])
    }

    func scheduleReminder(_ reminder: Reminder) async throws {
        // TODO: map Reminder to UNNotificationRequest
    }

    func cancelReminder(reminderId: String) async {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminderId])
    }
}
