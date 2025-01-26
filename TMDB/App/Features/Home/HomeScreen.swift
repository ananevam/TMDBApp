import SwiftUI
import Kingfisher

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModelAsync()
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                ScrollView {
                    VStack(alignment: .leading, spacing: 36) {
                        ContentSectionView(title: "Popular movies") {
                            HMoviesListView(movies: state.popularMovies)
                        }
                        ContentSectionView(title: "Trending movies") {
                            HMoviesListView(movies: state.trendingMovies)
                        }
//                        ContentSectionView(title: "Trending movies") {
//                            ForEach(state.trendingMovies) { movie in
//                                MovieListItemView(movie: movie)
//                            }
//                        }
                    }
                }.contentMargins(.horizontal, 16)
            }.navigationTitle("Movies")
        }.onLoad(viewModel.load)
    }
}

private struct HMoviesListView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(movies) { movie in
                    MovieCardView(movie: movie)
                }
            }
        }.scrollClipDisabled()
    }
}
