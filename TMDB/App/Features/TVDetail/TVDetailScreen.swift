import SwiftUI
import Kingfisher

struct TVDetailScreen: View {
    @StateObject private var viewModel: TVDetailViewModel

    init(tvShowId: Int) {
        _viewModel = StateObject(wrappedValue: TVDetailViewModel(tvShowId: tvShowId))
    }

    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                ScrollView {
                    VStack(spacing: 16) {
                        MoviePosterView(movie: state.show)
                        VStack(spacing: 36) {
                            MovieInfoView(movie: state.show)
                        }.padding(.horizontal, 16)
                    }
                }.navigationTitle(state.show.title).navigationBarTitleDisplayMode(.inline)
            }
        }.onLoad(viewModel.load)
    }
}
