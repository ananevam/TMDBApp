import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int
    let genres: [Genre]
    let runtime: Int
    let budget: Int?
    let revenue: Int?
    let tagline: String?
    let status: String

    enum BackdropSizes: String {
        case w300
        case w780
        case w1280
    }
    enum PosterSizes: String {
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
    }

    var posterImageURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    func posterImageURL(_ size: PosterSizes = .w500) -> URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(posterPath)")
    }

    var backdropImageURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
    }
    func backdropImageURL(_ size: BackdropSizes = .w780) -> URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(backdropPath)")
    }
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

    var releaseDateAsDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.date(from: releaseDate)
    }
    var releaseYear: String? {
        guard let date = releaseDateAsDate else {return nil}
        let calendar = Calendar.current
        return String(calendar.component(.year, from: date))
    }

    var runtimeFormatted: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        let dateComponents = DateComponents(minute: runtime)
        return formatter.string(from: dateComponents)
    }
}
