import Alamofire
import Combine
import Foundation

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
    
    func getPopularMoviesAsync() async throws -> MoviesResponse  {
        sleep(2)
        return try await request("movie/popular").serializingDecodable(MoviesResponse.self).value
    }

    func getPopularMovies(completion: @escaping (DataResponse<MoviesResponse, AFError>) -> Void) {
        request("movie/popular").responseDecodable(of: MoviesResponse.self, completionHandler: completion)
    }
    
    func getMovie(_ id: Int, completion: @escaping (DataResponse<MovieDetail, AFError>) -> Void) {
        request("movie/\(id)").responseDecodable(of: MovieDetail.self, completionHandler: completion)
    }
    
    func getMovieAsync(_ id: Int) async throws -> MovieDetail {
        try await request("movie/\(id)").serializingDecodable(MovieDetail.self).value
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
    func getTrendingMoviesAsync() async throws -> MoviesResponse {
        try await request("trending/movie/day").serializingDecodable(MoviesResponse.self).value
    }
    
    func executeConcurrentRequests<T1>(
        _ request1: @escaping () async throws -> T1
    ) async throws -> (T1) {
        async let result1 = request1()

        return try await (result1)
    }
    func executeConcurrentRequests<T1, T2>(
        _ request1: @escaping () async throws -> T1,
        _ request2: @escaping () async throws -> T2
    ) async throws -> (T1, T2) {
        async let result1 = request1()
        async let result2 = request2()

        return try await (result1, result2)
    }
}
