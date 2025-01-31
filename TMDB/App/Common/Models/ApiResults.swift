struct ApiResults<T: Decodable>: Decodable {
    let results: [T]
}
