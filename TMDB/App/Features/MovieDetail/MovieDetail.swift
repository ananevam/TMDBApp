import Foundation

struct MovieDetail: Decodable, Detailable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int
    let genres: [Genre]
    let runtime: Int?
    let budget: Int?
    let revenue: Int?
    let tagline: String?
    let status: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genres
        case runtime
        case budget
        case revenue
        case tagline
        case status
    }
}
