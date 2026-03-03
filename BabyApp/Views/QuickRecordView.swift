import SwiftUI

struct QuickRecordView: View {
    private let items: [EventType] = EventType.allCases

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("快速记录")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 12) {
                ForEach(items, id: \.self) { type in
                    NavigationLink {
                        EventFormView(defaultType: type)
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: icon(for: type))
                                .font(.title2)
                            Text(type.titleCN)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func icon(for type: EventType) -> String {
        switch type {
        case .milk: return "drop"
        case .solid: return "leaf"
        case .poop: return "tornado"
        case .sleep: return "bed.double"
        case .outing: return "figure.walk"
        }
    }
}
