import SwiftUI
import Alamofire

struct TVDetailState {
    let show: TVShowDetail
}

class TVDetailViewModel: BaseScreenViewModel<TVDetailState> {
    let tvShowId: Int

    init(tvShowId: Int) {
        self.tvShowId = tvShowId
    }

    override func fetch() async throws -> TVDetailState {
        async let requestShow = TMDBService.shared.getTVShow(self.tvShowId)

        let show = try await requestShow
        return TVDetailState(
            show: show
        )
    }
}
