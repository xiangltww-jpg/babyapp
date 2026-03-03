import SwiftUI

struct EventFormView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var vm: EventFormViewModel
    private let defaultType: EventType

    init(defaultType: EventType = .milk) {
        self.defaultType = defaultType
        _vm = StateObject(wrappedValue: EventFormViewModel(
            firestore: AppEnvironment.shared.firestoreService,
            locationService: AppEnvironment.shared.locationService
        ))
    }

    var body: some View {
        Form {
            Section("类型") {
                Picker("", selection: $vm.type) {
                    ForEach(EventType.allCases, id: \.self) { type in
                        Text(type.titleCN).tag(type)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section("时间") {
                DatePicker("开始", selection: $vm.startAt)
                if vm.type == .sleep || vm.type == .outing {
                    DatePicker("结束", selection: $vm.endAt)
                }
            }

            if vm.type == .milk {
                Section("喝奶") {
                    Picker("类型", selection: $vm.milkType) {
                        ForEach(MilkType.allCases, id: \.self) { t in
                            Text(t.titleCN).tag(t)
                        }
                    }
                    Stepper(value: $vm.amountMl, in: 10...400, step: 10) {
                        Text("奶量：\(vm.amountMl) ml")
                    }
                }
            }

            if vm.type == .outing {
                Section("外出") {
                    Toggle("记录定位", isOn: $vm.includeLocation)
                }
            }

            Section("备注") {
                TextField("活动内容/记忆点", text: $vm.note)
            }

            Section {
                Button("保存") {
                    guard let babyId = appState.selectedBaby?.id else { return }
                    Task { await vm.save(babyId: babyId) }
                }
            }
        }
        .navigationTitle("记录")
        .onAppear { vm.type = defaultType }
    }
}
