import SwiftUI

struct BabySwitchView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("当前宝宝")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("小熊")
                    .font(.title3.bold())
            }
            Spacer()
            Button("切换") {
                // TODO: open baby selector
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
    }
}
