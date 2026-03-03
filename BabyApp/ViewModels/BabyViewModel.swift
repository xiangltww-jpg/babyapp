import Foundation

@MainActor
final class BabyViewModel: ObservableObject {
    @Published var babies: [Baby] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let firestore: FirestoreService
    private let sync: SyncService

    init(firestore: FirestoreService, sync: SyncService) {
        self.firestore = firestore
        self.sync = sync
    }

    func loadBabies(familyId: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            babies = try await firestore.fetchBabies(familyId: familyId)
        } catch {
            errorMessage = "º”‘ÿ±¶±¶¡–±Ì ß∞‹"
        }
    }

    func select(baby: Baby) {
        sync.startSync(for: baby.id)
    }
}
