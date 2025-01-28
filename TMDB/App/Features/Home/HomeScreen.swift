import SwiftUI
import Kingfisher

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModelAsync()
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        let spacing = 36.0
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                ScrollView {
                    VStack(alignment: .leading, spacing: spacing) {
                        CarouselView(movies: state.nowPlaying)
                        VStack(alignment: .leading, spacing: spacing) {
                            ContentSectionView(title: "Genres") {
                                GenresListView(genres: state.genres)
                            }
                            ContentSectionView(title: "Popular movies") {
                                HMoviesListView(movies: state.popularMovies)
                            }
                            ContentSectionView(title: "Popular movies") {
                                HMoviesListView(movies: state.popularMovies)
                            }
                            ContentSectionView(title: "Trending movies") {
                                HMoviesListView(movies: state.trendingMovies)
                            }
                        }.padding(.horizontal, 16)
                        
                    }
                }//.contentMargins(.horizontal, 16)
            }.navigationTitle("Movies")
        }.onLoad(viewModel.load)
    }
}

struct HMoviesListView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(movies) { movie in
                    MovieCardView(movie: movie)
                }
            }.fixedSize(horizontal: false, vertical: true)
        }.scrollClipDisabled()
    }
}
