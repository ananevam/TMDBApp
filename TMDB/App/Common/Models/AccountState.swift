struct AccountState: Decodable {
    let id: Int
    let favorite: Bool
    let watchlist: Bool
    let rated: RatedValue

    enum RatedValue: Decodable {
        case rated(Double)
        case notRated

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let value = try? container.decode(Double.self) {
                self = .rated(value)
            } else if (try? container.decode(Bool.self)) != nil {
                self = .notRated
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Unexpected value for rated field"
                )
            }
        }
    }
}
