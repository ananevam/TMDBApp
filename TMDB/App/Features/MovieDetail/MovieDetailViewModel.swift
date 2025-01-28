import SwiftUI
import Alamofire

struct MovieDetailState {
    let movie: MovieDetail
    let recommendations: [Movie]
}

class MovieDetailViewModel: BaseScreenViewModel<MovieDetailState> {
    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
    
    override func fetch() async throws -> MovieDetailState {
        async let requestMovie = TMDBService.shared.getMovieAsync(self.movieId)
        async let requestRecommendations = TMDBService.shared.getMovieRecommendations(movieId: self.movieId)
        let (movie, recommendations) = try await (requestMovie, requestRecommendations)
        //return try await (requestMovie, requestRecommendations)
        return MovieDetailState(
            movie: movie,
            recommendations: recommendations.results
        )
    }
}
