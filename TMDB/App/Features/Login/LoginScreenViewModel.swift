import SwiftUI

class LoginScreenViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    func login(onSuccess: @escaping () -> Void) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let tokenResponse = try await TMDBService.shared.getNewToken()
                let validateLoginResponse = try await TMDBService.shared.validateLogin(
                    username: username, password: password, requestToken: tokenResponse.requestToken
                )
                let sessionResponse = try await TMDBService.shared.createSession(requestToken: validateLoginResponse.requestToken)
                UserDefaults.standard.set(sessionResponse.sessionID, forKey: "session_id")
                print("SUCCESS LOGIN")
                onSuccess()
            } catch {
                errorMessage = "Ошибка авторизации"
            }
        }
    }
}
