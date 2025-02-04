import Foundation

struct AccountResponse: Decodable {
    let id: Int
    let username: String
    let name: String?
    let includeAdult: Bool
    let avatar: Avatar

    enum CodingKeys: String, CodingKey {
        case id, username, name, avatar
        case includeAdult = "include_adult"
    }

    struct Gravatar: Decodable {
        let hash: String?
    }

    struct TmdbAvatar: Decodable {
        let avatarPath: String?
        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case avatarPath = "avatar_ath"
        }
    }

    struct Avatar: Decodable {
        let gravatar: Gravatar
        let tmdb: TmdbAvatar
    }

    var avatarImageURL: URL? {
        guard let avatarPath = avatar.tmdb.avatarPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(avatarPath)")
    }

    var gravatarImageURL: URL? {
        guard let hash = avatar.gravatar.hash else { return nil }
        return URL(string: "https://www.gravatar.com/avatar/\(hash)?s=500&d=identicon")
    }

}
