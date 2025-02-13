import SwiftUI

class WatchlistIconViewModel: ObservableObject {
    @Published var isWatchlist: Bool
    let state: AccountState

    init(_ state: AccountState) {
        self.state = state
        self.isWatchlist = state.watchlist
    }

    func onTap() {
        Task { @MainActor in
            guard case let .loggedIn(user, sessionId) = AuthManager.shared.state else {
                return
            }
            let newState = !isWatchlist
            _ = try await TMDBService.shared.markWatchlist(
                state.id,
                accountId: user.id,
                sessionId: sessionId,
                isWatchlist: newState
            )

            isWatchlist = newState
        }
    }
}
