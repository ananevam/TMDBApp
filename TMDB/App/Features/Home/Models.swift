
struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}


struct MoviesResponse: Codable {
    let results: [Movie]
}
