import SwiftUI
import Alamofire


class MovieDetailViewModel: BaseScreenViewModel<MovieDetail> {
    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }

    func fetch() {
        execute(request: { [weak self] completion in
            guard let self = self else {return}
            TMDBService.shared.getMovie(self.movieId, completion: completion)
        }) { [weak self] result in
            self?.state = .success(result)
        }
    }
}
