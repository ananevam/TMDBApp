struct ApiResults<T: Codable>: Codable {
    let results: [T]
}
