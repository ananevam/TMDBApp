import SwiftUI
import Kingfisher

struct MovieDetailScreen: View {
    @StateObject private var viewModel: MovieDetailViewModel
    @EnvironmentObject var theme: ThemeManager
    init(movieId: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }

    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                ScrollView {
                    VStack(spacing: 16) {
                        MoviePosterView(movie: state.movie)
                        VStack(spacing: 36) {
                            MovieInfoView(
                                movie: state.movie,
                                accountState: state.accountState
                            )
                            if !state.credits.cast.isEmpty {
                                ContentSectionView(title: "Cast") {
                                    HListCastView(items: state.credits.cast)
                                }
                            }
                            if !state.recommendations.isEmpty {
                                ContentSectionView(title: "Recommendations") {
                                    HListMoviesView(movies: state.recommendations)
                                }
                            }
                            if !state.similar.isEmpty {
                                ContentSectionView(title: "Similar movies") {
                                    HListMoviesView(movies: state.similar)
                                }
                            }
                            if !state.videos.isEmpty {
                                ContentSectionView(title: "Videos") {
                                    MovieVideosView(videos: state.videos)
                                }
                            }
                        }.padding(.horizontal, 16)
                    }
                }.navigationTitle(state.movie.title).navigationBarTitleDisplayMode(.inline)
            }
        }.onLoad(viewModel.load)
    }
}
