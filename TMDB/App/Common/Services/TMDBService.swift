import Alamofire
import Combine
import Foundation

class TMDBService {
    static let shared = TMDBService()
    private let apiKey = SecretsManager.shared.getValue(forKey: "API_KEY")
    private let accessToken = SecretsManager.shared.getValue(forKey: "ACCESS_TOKEN")
    private let baseURL = "https://api.themoviedb.org/3"
    private var cancellables = Set<AnyCancellable>()

    func request(_ url: String, method: HTTPMethod = .get, parameters: Parameters = [:]) -> DataRequest {
        let url = "\(baseURL)/\(url)"

//        let parameters: Parameters = [
//            "api_key": apiKey,
//            "language": Locale.preferredLanguages.first ?? "en-US"
//        ].merging(requestParameters) {$1}

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        return AF.request(url, method: method, parameters: parameters, headers: headers).validate()
    }

    func getPopularMovies() async throws -> ApiResults<Movie> {
        sleep(1)
        return try await request("movie/popular").serializingDecodable(ApiResults<Movie>.self).value
    }

    func getPopularMovies(completion: @escaping (DataResponse<ApiResults<Movie>, AFError>) -> Void) {
        request("movie/popular").responseDecodable(of: ApiResults<Movie>.self, completionHandler: completion)
    }

    func getMovie(_ id: Int) async throws -> MovieDetail {
        try await request("movie/\(id)").serializingDecodable(MovieDetail.self).value
    }
    func getMovieCredits(_ id: Int) async throws -> CreditsResponse {
        try await request("movie/\(id)/credits").serializingDecodable(CreditsResponse.self).value
    }

    func getTVShow(_ id: Int) async throws -> TVShowDetail {
        try await request("tv/\(id)").serializingDecodable(TVShowDetail.self).value
    }

    func getTVShowCredits(_ id: Int) async throws -> CreditsResponse {
        try await request("tv/\(id)/credits").serializingDecodable(CreditsResponse.self).value
    }

    func getPerson(_ id: Int) async throws -> Actor {
        try await request("person/\(id)").serializingDecodable(Actor.self).value
    }

    func getNowPlaying() async throws -> ApiResults<Movie> {
        try await request("movie/now_playing").serializingDecodable(ApiResults<Movie>.self).value
    }

    func getAccount(sessionId: String) async throws -> AccountResponse {
        let parameters: [String: Any] = [
            "session_id": sessionId
        ]
        return try await request("account", parameters: parameters).serializingDecodable(AccountResponse.self).value
    }

    func getGenres() async throws -> GenresResponse {
        try await request("genre/movie/list").serializingDecodable(GenresResponse.self).value
    }

    func getMovieRecommendations(_ movieId: Int) async throws -> ApiResults<Movie> {
        try await request("movie/\(movieId)/recommendations").serializingDecodable(ApiResults<Movie>.self).value
    }

    func getMovieSimilar(_ movieId: Int) async throws -> ApiResults<Movie> {
        try await request("movie/\(movieId)/similar").serializingDecodable(ApiResults<Movie>.self).value
    }

    func getMovieVideos(_ movieId: Int) async throws -> MovieVideosResponse {
        try await request("movie/\(movieId)/videos").serializingDecodable(MovieVideosResponse.self).value
    }

    func getPopularMoviesByGenreId(_ genreId: Int) async throws -> ApiResults<Movie> {
        let parameters: Parameters = [
            "with_genres": genreId,
            "sort_by": "popularity.desc"
        ]
        return try await request("discover/movie", parameters: parameters)
            .serializingDecodable(ApiResults<Movie>.self).value
    }

    func getTrendingMovies() async throws -> ApiResults<Movie> {
        try await request("trending/movie/day").serializingDecodable(ApiResults<Movie>.self).value
    }

    func getFavoriteMovies(accountId: Int, sessionId: String) async throws -> ApiResults<Movie> {
        let parameters: Parameters = [
            "session_id": sessionId,
        ]
        return try await request(
            "account/\(accountId)/favorite/movies",
            parameters: parameters
        ).serializingDecodable(ApiResults<Movie>.self).value
    }

    func getTrendingTv() async throws -> ApiResults<TVShow> {
        try await request("trending/tv/day").serializingDecodable(ApiResults<TVShow>.self).value
    }

    func getNewToken() async throws -> TokenResponse {
        try await request("authentication/token/new").serializingDecodable(TokenResponse.self).value
    }

    func validateLogin(username: String, password: String, requestToken: String) async throws -> TokenResponse {
        let parameters: [String: Any] = [
            "username": username,
            "password": password,
            "request_token": requestToken
        ]

        return try await request(
            "authentication/token/validate_with_login",
            method: .post,
            parameters: parameters
        ).serializingDecodable(TokenResponse.self).value
    }

    func createSession(requestToken: String) async throws -> SessionResponse {
        let parameters: [String: Any] = [
            "request_token": requestToken
        ]

        return try await request(
            "authentication/session/new", method: .post, parameters: parameters
        ).serializingDecodable(SessionResponse.self).value
    }
}
