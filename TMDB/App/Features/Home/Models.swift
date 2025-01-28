import Foundation

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let originalTitle: String
    let originalLanguage: String
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let genreIDs: [Int]
    let adult: Bool
    let video: Bool
    
    var backdropImageURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIDs = "genre_ids"
        case adult
        case video
    }
}
struct MoviesResponse: Codable {
    let results: [Movie]
}
struct GenresResponse: Codable {
    let genres: [Genre]
}

extension Movie {
    static var example: Movie {
        Movie(
            id: 1,
            title: ["Example Movie", "Long example movie"].randomElement()!,
            overview: "This is a description of the example movie.",
            posterPath: "/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg",
            backdropPath: "/b85bJfrTOSJ7M5Ox0yp4lxIxdG1.jpg",
            releaseDate: "2023-12-31",
            originalTitle: "Original Title",
            originalLanguage: "en",
            popularity: 100.0,
            voteAverage: 8.5,
            voteCount: 12345,
            genreIDs: [28, 12, 16],
            adult: false,
            video: false
        )
    }
    static func example(title: String) -> Movie {
        Movie(
            id: Int.random(in: 1000...9999),
            title: title,
            overview: "This is a description of the example movie.",
            posterPath: "/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg",
            backdropPath: "/b85bJfrTOSJ7M5Ox0yp4lxIxdG1.jpg",
            releaseDate: "2023-12-31",
            originalTitle: "Original Title",
            originalLanguage: "en",
            popularity: 100.0,
            voteAverage: 8.5,
            voteCount: 12345,
            genreIDs: [28, 12, 16],
            adult: false,
            video: false
        )
    }
}
