import Foundation

struct MovieVideosResponse: Codable {
    let results: [MovieVideo]
}
struct MovieVideo: Codable, Identifiable {
    let id: String
    let iso6391: String
    let iso31661: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case name
        case key
        case site
        case size
        case type
        case official
        case publishedAt = "published_at"
    }

    var thumbnailURL: URL {
        return URL(string: "https://img.youtube.com/vi/\(key)/0.jpg")!
    }
    var youtubeURL: URL {
        URL(string: "https://www.youtube.com/watch?v=\(key)")!
    }
}
