import SwiftUI

class FavoriteIconViewModel: ObservableObject {
    @Published var isFavorite: Bool
    let state: AccountState

    init(_ state: AccountState) {
        self.state = state
        self.isFavorite = state.favorite
    }

    func onTap() {
        Task { @MainActor in
            guard case let .loggedIn(user, sessionId) = AuthManager.shared.state else {
                return
            }
            let newState = !isFavorite
            _ = try await TMDBService.shared.markFavorite(
                state.id,
                accountId: user.id,
                sessionId: sessionId,
                isFavorite: newState
            )

            isFavorite = newState
        }
    }
}
