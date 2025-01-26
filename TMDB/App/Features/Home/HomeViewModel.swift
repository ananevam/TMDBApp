import SwiftUI
import Alamofire

struct HomeState {
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

        let (popular, trending, nowPlaying) = try await (popularRequest, trendingRequest, notPlayingRequest)
        return HomeState(popularMovies: popular.results, trendingMovies: trending.results, nowPlaying: nowPlaying.results)
    }
}
