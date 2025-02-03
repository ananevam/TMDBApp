import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: AccountResponse?

    @MainActor
    func checkSession() {
        print("CHECK SESSIONB")
        if let sessionId = KeychainManager.shared.getString(key: "sessionId") {
            print("SESSION_ID = \(sessionId)")
            Task {
                await fetchUserProfile(sessionId: sessionId)
            }
        } else {
            isAuthenticated = false
        }
    }
    @MainActor
    func fetchUserProfile(sessionId: String) async {
        do {
            let account = try await TMDBService.shared.getAccount(sessionId: sessionId)
            self.user = account
            self.isAuthenticated = true
        } catch {
            self.user = nil
            self.isAuthenticated = false
        }
    }
    func logout() {
        KeychainManager.shared.delete(key: "sessionId")
        self.user = nil
        self.isAuthenticated = false
    }
}
