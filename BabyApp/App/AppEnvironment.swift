import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var currentUser: UserProfile?
    @Published var selectedBaby: Baby?
    @Published var isAuthenticated: Bool = false

    let environment: AppEnvironment

    init(environment: AppEnvironment = AppEnvironment.shared) {
        self.environment = environment
        bindAuth()
    }

    private func bindAuth() {
        environment.authService.authStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.currentUser = user
                self?.isAuthenticated = user != nil
            }
            .store(in: &environment.cancellables)
    }
}

final class AppEnvironment {
    static let shared = AppEnvironment()

    let authService: AuthService
    let firestoreService: FirestoreService
    let syncService: SyncService
    let locationService: LocationService
    let notificationService: NotificationService
    let reportService: ReportService
    var cancellables = Set<AnyCancellable>()

    init(
        authService: AuthService = FirebaseAuthService(),
        firestoreService: FirestoreService = FirebaseFirestoreService(),
        syncService: SyncService = DefaultSyncService(),
        locationService: LocationService = CoreLocationService(),
        notificationService: NotificationService = UserNotificationService(),
        reportService: ReportService = DefaultReportService()
    ) {
        self.authService = authService
        self.firestoreService = firestoreService
        self.syncService = syncService
        self.locationService = locationService
        self.notificationService = notificationService
        self.reportService = reportService
    }
}
