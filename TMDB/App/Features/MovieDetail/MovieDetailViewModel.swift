import SwiftUI
import Alamofire

struct MovieDetailState {
    let movie: MovieDetail
    let recommendations: [Movie]
    let similar: [Movie]
    let videos: [MovieVideo]
}

class MovieDetailViewModel: BaseScreenViewModel<MovieDetailState> {
    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }

    override func fetch() async throws -> MovieDetailState {
        async let requestMovie = TMDBService.shared.getMovieAsync(self.movieId)
        async let requestRecommendations = TMDBService.shared.getMovieRecommendations(movieId: self.movieId)
        async let requestSimilar = TMDBService.shared.getMovieSimilar(movieId: self.movieId)
        async let requestVideos = TMDBService.shared.getMovieVideos(movieId: self.movieId)
        let (movie, recommendations, similar, videos) = try await (
            requestMovie,
            requestRecommendations,
            requestSimilar,
            requestVideos
        )
        // return try await (requestMovie, requestRecommendations)
        return MovieDetailState(
            movie: movie,
            recommendations: recommendations.results,
            similar: similar.results,
            videos: videos.results
        )
    }
}
