import SwiftUI
import Alamofire

struct HomeState {
    let popularMovies: [Movie]
    let trendingMovies: [Movie]
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
        async let request1 = TMDBService.shared.getPopularMoviesAsync()
        async let request2 = TMDBService.shared.getTrendingMoviesAsync()

        let (popular, trending) = try await (request1, request2)
        return HomeState(popularMovies: popular.results, trendingMovies: trending.results)
        
//        let response = try await TMDBService.shared.getPopularMoviesAsync()
//        return response.results
    }
}
