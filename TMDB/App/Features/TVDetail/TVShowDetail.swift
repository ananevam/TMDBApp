import Foundation

struct TVShowDetail: Decodable, Detailable {
    var runtime: Int?

    let id: Int
    let name: String
    var title: String {
        name
    }
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    var releaseDate: String? {
        firstAirDate
    }
    let lastAirDate: String?
    let numberOfSeasons: Int
    let numberOfEpisodes: Int
    let voteAverage: Double
    let voteCount: Int
    let genres: [Genre]
    let status: String

    enum CodingKeys: String, CodingKey {
        case id, name, overview, genres, status
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
