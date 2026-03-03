import Foundation
import Combine

protocol AuthService {
    var authStatePublisher: AnyPublisher<UserProfile?, Never> { get }
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func signOut() async throws
}

final class FirebaseAuthService: AuthService {
    private let subject = CurrentValueSubject<UserProfile?, Never>(nil)

    var authStatePublisher: AnyPublisher<UserProfile?, Never> {
        subject.eraseToAnyPublisher()
    }

    func signIn(email: String, password: String) async throws {
        // TODO: Firebase Auth sign-in
        subject.send(UserProfile(id: UUID().uuidString, email: email, displayName: nil, createdAt: Date()))
    }

    func signUp(email: String, password: String) async throws {
        // TODO: Firebase Auth sign-up
        subject.send(UserProfile(id: UUID().uuidString, email: email, displayName: nil, createdAt: Date()))
    }

    func signOut() async throws {
        // TODO: Firebase Auth sign-out
        subject.send(nil)
    }
}
