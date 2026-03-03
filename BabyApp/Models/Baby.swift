import Foundation

struct Baby: Identifiable, Codable, Equatable {
    let id: String
    var familyId: String
    var name: String
    var birthDate: Date
    var gender: String?
    var createdAt: Date
}
