import Alamofire
import Combine

class TMDBService {
    static let shared = TMDBService()
    private let apiKey = SecretsManager.shared.getValue(forKey: "API_KEY")
    private let baseURL = "https://api.themoviedb.org/3"
    
    private var cancellables = Set<AnyCancellable>()
    
    func request(_ url: String) -> DataRequest {
        let url = "\(baseURL)/\(url)"
        let parameters: Parameters = ["api_key": apiKey, "language": "ru-RU"]
        return AF.request(url, parameters: parameters).validate()
    }
    
//    func popularMovies() async throws -> [Movie] {
//        let response = try await request("movie/popular").serializingDecodable(MoviesResponse.self).value
//        return response.results
//    }
    func getPopularMovies(completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        request("movie/popular").responseDecodable(of: MoviesResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                completion(.success(movieResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovie(_ id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        request("movie/\(id)").responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let movieResponse):
                completion(.success(movieResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
