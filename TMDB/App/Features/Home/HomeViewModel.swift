import SwiftUI
import Alamofire


class HomeViewModel: BaseScreenViewModel<[Movie]> {
    func fetch() {
        execute(request: TMDBService.shared.getPopularMovies) { [weak self] movies in
            self?.state = .success(movies.results)
        }
    }
}
