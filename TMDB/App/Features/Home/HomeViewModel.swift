import SwiftUI
import Combine
import Alamofire


class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var loading: Bool = false
    @Published var error: String?

    private let apiKey = SecretsManager.shared.getValue(forKey: "API_KEY")

    init() {
        fetchPopularMovies()
    }

    func fetchPopularMovies() {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=ru-RU"

        self.loading = true
        self.error = nil
        AF.request(url).responseDecodable(of: MoviesResponse.self) {[weak self] response in
            guard let self else { return }
            self.loading = false

            switch response.result {
            case .success(let data):
                self.movies = data.results
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}
