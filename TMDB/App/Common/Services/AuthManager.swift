import SwiftUI

@MainActor
class AuthManager: ObservableObject {
    @Published var state: State = .notLoggedIn {
        didSet { saveState() }
    }

    enum State {
        case loggedIn(AccountResponse, String)
        case notLoggedIn
    }

    let sessionStoreKey = "sessionId"
    let userStoreKey = "user"

    static let shared: AuthManager = AuthManager()

    init() {
        loadState()
    }

    func onLogin(user: AccountResponse, sessionId: String) {
        self.state = .loggedIn(user, sessionId)
    }
    func logout() {
        self.state = .notLoggedIn
    }

    private func saveState() {
        switch state {
        case .loggedIn(let user, let sessionId):
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: userStoreKey)
                KeychainManager.shared.save(key: sessionStoreKey, string: sessionId)
            }
        case .notLoggedIn:
            UserDefaults.standard.set(nil, forKey: userStoreKey)
            KeychainManager.shared.delete(key: sessionStoreKey)
        }
    }
    private func loadState() {
        if let data = UserDefaults.standard.data(forKey: userStoreKey),
           let user = try? JSONDecoder().decode(AccountResponse.self, from: data),
           let sessionId = KeychainManager.shared.getString(key: sessionStoreKey) {
            self.state = .loggedIn(user, sessionId)
        }
    }
}
