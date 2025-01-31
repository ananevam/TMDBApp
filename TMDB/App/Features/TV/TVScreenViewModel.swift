import SwiftUI
import Alamofire

class TVScreenViewModel: BaseScreenViewModel<[TVShow]> {
    override func fetch() async throws -> [TVShow] {
        async let request = TMDBService.shared.getTrendingTv()

        let response = try await request
        return response.results
    }
}
