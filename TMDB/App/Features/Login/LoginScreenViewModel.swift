import SwiftUI
import Combine

class LoginScreenViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var isDisabled: Bool = true

    private var cancellables = Set<AnyCancellable>()
    var onSuccess: ((String) -> Void)?

    init() {
        Publishers.CombineLatest($username, $password)
            .map { $0.trimmed.isEmpty || $1.trimmed.isEmpty }
            .assign(to: \.isDisabled, on: self)
            .store(in: &cancellables)
    }

    func login() {
        isLoading = true
        errorMessage = nil

        Task { @MainActor in
            defer {
                isLoading = false
            }
            do {
                let tokenResponse = try await TMDBService.shared.getNewToken()
                let validateLoginResponse = try await TMDBService.shared.validateLogin(
                    username: username, password: password, requestToken: tokenResponse.requestToken
                )
                let sessionResponse = try await TMDBService.shared.createSession(
                    requestToken: validateLoginResponse.requestToken
                )

//                KeychainManager.shared.save(key: "sessionId", string: sessionResponse.sessionID)
                print("SUCCESS LOGIN")
//                onSuccess()
                AuthManager.shared.sessionId = sessionResponse.sessionID
            } catch {
                errorMessage = "Ошибка авторизации"
            }
        }
    }
}
