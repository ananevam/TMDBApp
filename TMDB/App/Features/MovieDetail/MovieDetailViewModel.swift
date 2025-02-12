import SwiftUI
import Alamofire

struct MovieDetailState {
    let movie: MovieDetail
    let recommendations: [Movie]
    let similar: [Movie]
    let videos: [MovieVideo]
    let credits: CreditsResponse
    let accountState: AccountState?
}

class MovieDetailViewModel: BaseScreenViewModel<MovieDetailState> {
    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }

    override func fetch() async throws -> MovieDetailState {
        async let requestMovie = TMDBService.shared.getMovie(self.movieId)
        async let requestRecommendations = TMDBService.shared.getMovieRecommendations(self.movieId)
        async let requestSimilar = TMDBService.shared.getMovieSimilar(self.movieId)
        async let requestVideos = TMDBService.shared.getMovieVideos(self.movieId)
        async let requestCredits = TMDBService.shared.getMovieCredits(self.movieId)

        async let requestAccountState: AccountState? = {
            if case let .loggedIn(_, sessionId) = await AuthManager.shared.state {
                return try await TMDBService.shared.getMovieAccountState(self.movieId, sessionId: sessionId)
            }
            return nil
        }()

        let (movie, recommendations, similar, videos, credits, accountState) = try await (
            requestMovie,
            requestRecommendations,
            requestSimilar,
            requestVideos,
            requestCredits,
            requestAccountState
        )

        return MovieDetailState(
            movie: movie,
            recommendations: recommendations.results,
            similar: similar.results,
            videos: videos.results,
            credits: credits,
            accountState: accountState
        )
    }
}
