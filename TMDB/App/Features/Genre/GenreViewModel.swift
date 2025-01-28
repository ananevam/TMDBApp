import SwiftUI
import Alamofire

struct GenreState {
    let genre: Genre
    let movies: [Movie]
}

class GenreViewModel: BaseScreenViewModel<GenreState> {
    let genre: Genre

    init(genre: Genre) {
        self.genre = genre
    }
    override func fetch() async throws -> GenreState {
        async let request = TMDBService.shared.getPopularMoviesByGenreId(genre.id)

        let response = try await request
        return GenreState(
            genre: genre,
            movies: response.results
        )
    }
}
