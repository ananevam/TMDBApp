struct ProfileScreenState {
    let favoriteMovies: [Movie]
}
class ProfileScreenViewModel: BaseScreenViewModel<ProfileScreenState> {

    override func fetch() async throws -> ProfileScreenState {
        let auth = await AuthManager.shared

        guard case let .loggedIn(user, sessionId) = await auth.state else {
            fatalError("Ошибка")
        }
        async let requestFavoriteMovies = TMDBService.shared.getFavoriteMovies(
            accountId: user.id, sessionId: sessionId
        )

        let favoriteMoviesResponse = try await requestFavoriteMovies

        return ProfileScreenState(
            favoriteMovies: favoriteMoviesResponse.results
        )
    }
}
