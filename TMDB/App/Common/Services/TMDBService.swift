import Alamofire
import Combine
import Foundation

class TMDBService {
    static let shared = TMDBService()
    private let apiKey = SecretsManager.shared.getValue(forKey: "API_KEY")
    private let baseURL = "https://api.themoviedb.org/3"
    
    private var cancellables = Set<AnyCancellable>()
    
    func request(_ url: String, parameters requestParameters: Parameters = [:]) -> DataRequest {
        let url = "\(baseURL)/\(url)"
        let parameters: Parameters = ["api_key": apiKey, "language": "ru-RU"].merging(requestParameters) {$1}
        return AF.request(url, parameters: parameters).validate()
    }
    
    func getPopularMoviesAsync() async throws -> MoviesResponse  {
        sleep(1)
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
    
    func getNowPlaying() async throws -> MoviesResponse {
        try await request("movie/now_playing").serializingDecodable(MoviesResponse.self).value
    }
    
    func getGenres() async throws -> GenresResponse {
        try await request("genre/movie/list").serializingDecodable(GenresResponse.self).value
    }
    
    func getMovieRecommendations(movieId: Int) async throws -> MoviesResponse {
        try await request("movie/\(movieId)/recommendations").serializingDecodable(MoviesResponse.self).value
    }
    
    func getMovieSimilar(movieId: Int) async throws -> MoviesResponse {
        try await request("movie/\(movieId)/similar").serializingDecodable(MoviesResponse.self).value
    }
    
    func getMovieVideos(movieId: Int) async throws -> MovieVideosResponse {
        try await request("movie/\(movieId)/videos").serializingDecodable(MovieVideosResponse.self).value
    }
    
    func getPopularMoviesByGenreId(_ genreId: Int) async throws -> MoviesResponse {
        let parameters: Parameters = [
            "with_genres": genreId,
            "sort_by": "popularity.desc"
        ]
        return try await request("discover/movie", parameters: parameters).serializingDecodable(MoviesResponse.self).value
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
}
