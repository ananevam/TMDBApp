import SwiftUI

class UserViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: AccountResponse?

    func checkSession() {
        if let sessionId = UserDefaults.standard.string(forKey: "session_id") {
            print("SESSION_ID = \(sessionId)")
            Task {
                await fetchUserProfile(sessionId: sessionId)
            }
        } else {
            isAuthenticated = false
        }
    }
    func fetchUserProfile(sessionId: String) async {
        do {
            let account = try await TMDBService.shared.getAccount(sessionId: sessionId)
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.user = account
                self.isAuthenticated = true
            }
        } catch {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.user = nil
                self.isAuthenticated = false
            }
        }
    }
    func logout() {
        UserDefaults.standard.removeObject(forKey: "session_id")
        print("Logout and remove session id")
        DispatchQueue.main.async {
            self.user = nil
            self.isAuthenticated = false
        }
    }
}
