import SwiftUI
import Alamofire

struct HomeState {
    let genres: [Genre]
    let popularMovies: [Movie]
    let trendingMovies: [Movie]
    let nowPlaying: [Movie]
}

class HomeViewModel: BaseScreenViewModelClosure<[Movie]> {
    func fetch() {
        execute(request: TMDBService.shared.getPopularMovies) { [weak self] movies in
            self?.state = .success(movies.results)
        }
    }
}

class HomeViewModelAsync: BaseScreenViewModelAsync<HomeState> {
    override func fetch() async throws -> HomeState {
        async let popularRequest = TMDBService.shared.getPopularMoviesAsync()
        async let trendingRequest = TMDBService.shared.getTrendingMoviesAsync()
        async let notPlayingRequest = TMDBService.shared.getNowPlaying()
        async let genresRequest = TMDBService.shared.getGenres()

        let (genres, popular, trending, nowPlaying) = try await (
            genresRequest,
            popularRequest,
            trendingRequest,
            notPlayingRequest
        )
        return HomeState(
            genres: genres.genres,
            popularMovies: popular.results,
            trendingMovies: trending.results,
            nowPlaying: nowPlaying.results
        )
    }
}
