import Foundation

struct TVShow: Decodable, Identifiable, Hashable, MovieCardViewItem {
    var title: String {
        name
    }

    let id: Int
    let name: String
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
    }

    // Переводим оценку в формат string для отображения
    var voteAverageString: String {
        String(format: "%.1f", voteAverage)
    }

    // Создаем URL для изображения
    var posterImageURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropImageURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }

    func navigationLinkValue() -> Screens { Screens.tvShow(id) }
}
