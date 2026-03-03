import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var vm: LoginViewModel

    init() {
        _vm = StateObject(wrappedValue: LoginViewModel(authService: AppEnvironment.shared.authService))
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("宝宝记录")
                .font(.largeTitle.bold())

            TextField("邮箱", text: $vm.email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)

            SecureField("密码", text: $vm.password)
                .textFieldStyle(.roundedBorder)

            if let error = vm.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }

            HStack(spacing: 12) {
                Button("登录") {
                    Task { await vm.signIn() }
                }
                .buttonStyle(.borderedProminent)

                Button("注册") {
                    Task { await vm.signUp() }
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}
