import Foundation

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

protocol Detailable {
    var id: Int { get }
    var title: String { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var status: String { get }
    var releaseDate: String? { get }
    var runtime: Int? { get }
    var voteAverage: Double { get }
    var overview: String? { get }
    var genres: [Genre] { get }

    func backdropImageURL(_ size: BackdropSizes) -> URL?
    func posterImageURL(_ size: PosterSizes) -> URL?
}

extension Detailable {
    var posterImageURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropImageURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
    }
    func backdropImageURL(_ size: BackdropSizes = .w780) -> URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(backdropPath)")
    }
    func posterImageURL(_ size: PosterSizes = .w500) -> URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(posterPath)")
    }

    var releaseDateAsDate: Date? {
        guard let releaseDate = releaseDate else { return nil }
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
        guard let runtime = runtime else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        let dateComponents = DateComponents(minute: runtime)
        return formatter.string(from: dateComponents)
    }
}
