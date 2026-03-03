import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func signIn() async {
        isLoading = true
        defer { isLoading = false }
        do {
            try await authService.signIn(email: email, password: password)
        } catch {
            errorMessage = "µ«¬º ß∞‹£¨«Î÷ÿ ‘"
        }
    }

    func signUp() async {
        isLoading = true
        defer { isLoading = false }
        do {
            try await authService.signUp(email: email, password: password)
        } catch {
            errorMessage = "◊¢≤· ß∞‹£¨«Î÷ÿ ‘"
        }
    }
}
