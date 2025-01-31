import Foundation

struct Actor: Decodable, Identifiable {
    let id: Int
    let name: String
    // let character: String
    let profilePath: String?
    let biography: String?
    let gender: Int?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, gender, order, biography
        case profilePath = "profile_path"
    }

    var profileImageURL: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
}

struct CrewMember: Decodable, Identifiable {
    let id: Int
    let name: String
    let job: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, job
        case profilePath = "profile_path"
    }
}

struct CreditsResponse: Decodable {
    let cast: [Actor]
    let crew: [CrewMember]

    enum CodingKeys: String, CodingKey {
        case cast, crew
    }
}
