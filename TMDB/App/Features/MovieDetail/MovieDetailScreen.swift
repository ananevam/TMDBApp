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
                            MovieInfoView(movie: state.movie)
                            if !state.recommendations.isEmpty {
                                ContentSectionView(title: "Recommendations") {
                                    HMoviesListView(movies: state.recommendations)
                                }
                            }
                            if !state.similar.isEmpty {
                                ContentSectionView(title: "Similar movies") {
                                    HMoviesListView(movies: state.similar)
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
