import SwiftUI
import Alamofire

struct TVDetailState {
    let show: TVShowDetail
    let credits: CreditsResponse
}

class TVDetailViewModel: BaseScreenViewModel<TVDetailState> {
    let tvShowId: Int

    init(tvShowId: Int) {
        self.tvShowId = tvShowId
    }

    override func fetch() async throws -> TVDetailState {
        async let requestShow = TMDBService.shared.getTVShow(self.tvShowId)
        async let requestCredits = TMDBService.shared.getTVShowCredits(self.tvShowId)

        let (show, credits) = try await (requestShow, requestCredits)
        return TVDetailState(
            show: show,
            credits: credits
        )
    }
}
