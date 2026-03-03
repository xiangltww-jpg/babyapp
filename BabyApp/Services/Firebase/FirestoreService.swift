import Foundation

protocol FirestoreService {
    func fetchBabies(familyId: String) async throws -> [Baby]
    func createBaby(_ baby: Baby) async throws
    func updateBaby(_ baby: Baby) async throws
    func deleteBaby(babyId: String) async throws

    func fetchEvents(babyId: String, from: Date, to: Date) async throws -> [Event]
    func createEvent(_ event: Event) async throws
    func updateEvent(_ event: Event) async throws
    func deleteEvent(eventId: String) async throws

    func fetchReminders(babyId: String) async throws -> [Reminder]
    func upsertReminder(_ reminder: Reminder) async throws
    func deleteReminder(reminderId: String) async throws
}

final class FirebaseFirestoreService: FirestoreService {
    func fetchBabies(familyId: String) async throws -> [Baby] { [] }
    func createBaby(_ baby: Baby) async throws {}
    func updateBaby(_ baby: Baby) async throws {}
    func deleteBaby(babyId: String) async throws {}

    func fetchEvents(babyId: String, from: Date, to: Date) async throws -> [Event] { [] }
    func createEvent(_ event: Event) async throws {}
    func updateEvent(_ event: Event) async throws {}
    func deleteEvent(eventId: String) async throws {}

    func fetchReminders(babyId: String) async throws -> [Reminder] { [] }
    func upsertReminder(_ reminder: Reminder) async throws {}
    func deleteReminder(reminderId: String) async throws {}
}
