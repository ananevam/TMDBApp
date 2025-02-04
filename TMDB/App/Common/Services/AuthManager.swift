import SwiftUI

@MainActor
class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: AccountResponse?
    let sessionStoreKey = "sessionId"

    static let shared: AuthManager = AuthManager()

    var sessionId: String? {
        didSet {
            sessionIdDidSet()
        }
    }
    init() {
        sessionId = KeychainManager.shared.getString(key: sessionStoreKey)
        sessionIdDidSet()
    }
    private func sessionIdDidSet() {
        isAuthenticated = sessionId != nil
        if let sessionId = sessionId {
            KeychainManager.shared.save(key: sessionStoreKey, string: sessionId)
            Task {
                await fetchUserProfile(sessionId: sessionId)
            }
        } else {
            user = nil
            KeychainManager.shared.delete(key: sessionStoreKey)
        }
    }

    @MainActor
    func fetchUserProfile(sessionId: String) async {
        do {
            let account = try await TMDBService.shared.getAccount(sessionId: sessionId)
            self.user = account
        } catch {
            // self.user = nil
            // self.isAuthenticated = false
        }
    }
//    func onSuccessLogin(_ sessionId: String) {
//        self.sessionId = sessionId
//    }
    func logout() {
        sessionId = nil
    }
}
