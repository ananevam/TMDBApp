import SwiftUI
import Alamofire


class MovieDetailViewModel: BaseScreenViewModel<MovieDetail> {
    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
    
    override func fetch() async throws -> MovieDetail {
        async let request = TMDBService.shared.getMovieAsync(self.movieId)
        return try await request
    }
}
