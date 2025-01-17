import SwiftUI
import Combine
import Alamofire


class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var loading: Bool = false
    @Published var error: String?

    private let apiKey = SecretsManager.shared.getValue(forKey: "API_KEY")
    private var cancellables = Set<AnyCancellable>()

    func fetchPopularMovies() {
        loading = true
        error = nil

      guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=ru-RU") else {
            self.error = "Invalid URL"
            self.loading = false
            return
      }

      AF.request(url)
          .validate()
          .publishDecodable(type: MoviesResponse.self)
          .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.loading = false
            case .failure(let err):
                self.error = err.localizedDescription
                self.loading = false
            }
        }, receiveValue: { [weak self] response in
              self?.movies = response.value?.results ?? []
        })
          .store(in: &cancellables)
    }
}
