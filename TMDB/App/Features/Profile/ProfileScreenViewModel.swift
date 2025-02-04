struct ProfileScreenState {
    let favoriteMovies: [Movie]
}
class ProfileScreenViewModel: BaseScreenViewModel<ProfileScreenState> {
    private var userViewModel: UserViewModel?
    override func fetch() async throws -> ProfileScreenState {
        guard let accountId = await userViewModel?.user?.id,
                  let sessionId = await userViewModel?.sessionId else {
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
    func configure(_ userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
    }
}
