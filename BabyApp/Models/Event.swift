import Foundation

enum EventType: String, Codable, CaseIterable {
    case milk
    case solid
    case poop
    case sleep
    case outing

    var titleCN: String {
        switch self {
        case .milk: return "ºÈÄÌ"
        case .solid: return "¸¨Ê³"
        case .poop: return "±ã±ã"
        case .sleep: return "Ë¯Ãß"
        case .outing: return "Íâ³ö"
        }
    }
}

enum MilkType: String, Codable, CaseIterable {
    case breast
    case formula
    case mixed

    var titleCN: String {
        switch self {
        case .breast: return "Ä¸Èé"
        case .formula: return "Åä·½"
        case .mixed: return "»ìºÏ"
        }
    }
}

struct Event: Identifiable, Codable, Equatable {
    let id: String
    var babyId: String
    var type: EventType
    var startAt: Date
    var endAt: Date?
    var amountMl: Int?
    var milkType: MilkType?
    var note: String?
    var location: EventLocation?
    var createdAt: Date
    var updatedAt: Date

    var durationMinutes: Int? {
        guard let endAt else { return nil }
        return Int(endAt.timeIntervalSince(startAt) / 60)
    }
}

struct EventLocation: Codable, Equatable {
    var latitude: Double
    var longitude: Double
    var placeName: String?
}
