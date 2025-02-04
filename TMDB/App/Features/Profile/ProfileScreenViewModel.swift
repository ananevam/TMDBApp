struct ProfileScreenState {
    let favoriteMovies: [Movie]
}
class ProfileScreenViewModel: BaseScreenViewModel<ProfileScreenState> {
    override func fetch() async throws -> ProfileScreenState {
        let auth = await AuthManager.shared
        guard let accountId = await auth.user?.id,
                  let sessionId = await auth.sessionId else {
            fatalError("Ошибка")
        }
        async let requestFavoriteMovies = TMDBService.shared.getFavoriteMovies(
            accountId: accountId, sessionId: sessionId
        )

        let favoriteMoviesResponse = try await requestFavoriteMovies

        return ProfileScreenState(
            favoriteMovies: favoriteMoviesResponse.results
        )
    }
}
