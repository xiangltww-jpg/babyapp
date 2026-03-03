import Foundation
import CoreLocation

@MainActor
final class EventFormViewModel: ObservableObject {
    @Published var type: EventType = .milk
    @Published var startAt: Date = Date()
    @Published var endAt: Date = Date()
    @Published var amountMl: Int = 120
    @Published var milkType: MilkType = .breast
    @Published var note: String = ""
    @Published var includeLocation: Bool = false
    @Published var isLoading: Bool = false

    private let firestore: FirestoreService
    private let locationService: LocationService

    init(firestore: FirestoreService, locationService: LocationService) {
        self.firestore = firestore
        self.locationService = locationService
    }

    func save(babyId: String) async {
        isLoading = true
        defer { isLoading = false }

        var location: EventLocation?
        if includeLocation {
            do {
                let current = try await locationService.currentLocation()
                location = EventLocation(latitude: current.coordinate.latitude, longitude: current.coordinate.longitude, placeName: nil)
            } catch {
                location = nil
            }
        }

        let event = Event(
            id: UUID().uuidString,
            babyId: babyId,
            type: type,
            startAt: startAt,
            endAt: type == .sleep || type == .outing ? endAt : nil,
            amountMl: type == .milk ? amountMl : nil,
            milkType: type == .milk ? milkType : nil,
            note: note.isEmpty ? nil : note,
            location: location,
            createdAt: Date(),
            updatedAt: Date()
        )

        do {
            try await firestore.createEvent(event)
        } catch {
            // TODO: handle error
        }
    }
}
