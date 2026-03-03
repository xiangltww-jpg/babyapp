import Foundation

struct UserProfile: Identifiable, Codable, Equatable {
    let id: String
    var email: String
    var displayName: String?
    var createdAt: Date
}
