struct TokenResponse: Decodable {
    let success: Bool
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case requestToken = "request_token"
    }
}
