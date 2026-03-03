import Foundation

enum ReminderMode: String, Codable, CaseIterable {
    case fixedTime
    case habitBased
    case custom

    var titleCN: String {
        switch self {
        case .fixedTime: return "固定时间"
        case .habitBased: return "习惯提醒"
        case .custom: return "自定义"
        }
    }
}

struct Reminder: Identifiable, Codable, Equatable {
    let id: String
    var babyId: String
    var type: EventType
    var mode: ReminderMode
    var time: Date?
    var intervalMinutes: Int?
    var enabled: Bool
    var createdAt: Date
}
