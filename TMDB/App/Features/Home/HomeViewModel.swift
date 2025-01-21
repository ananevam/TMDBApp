import SwiftUI
import Alamofire


class MovieViewModel: BaseScreenViewModel {
    @Published var movies: [Movie] = []

    func fetch() {
        execute(request: TMDBService.shared.popularMoviesClosure) { [weak self] movies in
            self?.movies = movies.results
        }
    }
}
