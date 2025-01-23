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
    func getPopularMovies(completion: @escaping (DataResponse<MoviesResponse, AFError>) -> Void) {
        request("movie/popular").responseDecodable(of: MoviesResponse.self, completionHandler: completion)
//        request("movie/popular").responseDecodable(of: MoviesResponse.self) { response in
//            switch response.result {
//            case .success(let result):
//                completion(.success(result))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
    
    func getMovie(_ id: Int, completion: @escaping (DataResponse<MovieDetail, AFError>) -> Void) {
        request("movie/\(id)").responseDecodable(of: MovieDetail.self, completionHandler: completion)
//        request("movie/\(id)").responseDecodable(of: MovieDetail.self) { response in
//            switch response.result {
//            case .success(let movieResponse):
//                completion(.success(movieResponse))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
    
    func getTrendingMovies(completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        request("trending/movie/day").responseDecodable(of: MoviesResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
