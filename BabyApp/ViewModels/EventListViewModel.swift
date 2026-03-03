import Foundation

@MainActor
final class EventListViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading: Bool = false

    private let firestore: FirestoreService

    init(firestore: FirestoreService) {
        self.firestore = firestore
    }

    func loadEvents(babyId: String, from: Date, to: Date) async {
        isLoading = true
        defer { isLoading = false }
        do {
            events = try await firestore.fetchEvents(babyId: babyId, from: from, to: to)
        } catch {
            events = []
        }
    }
}
