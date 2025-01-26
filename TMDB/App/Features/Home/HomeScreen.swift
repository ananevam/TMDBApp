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
                        CarouselView(movies: state.nowPlaying)
                        ContentSectionView(title: "Popular movies") {
                            HMoviesListView(movies: state.popularMovies)
                        }.padding(.horizontal, 16)
                        ContentSectionView(title: "Trending movies") {
                            HMoviesListView(movies: state.trendingMovies)
                        }.padding(.horizontal, 16)
                    }
                }//.contentMargins(.horizontal, 16)
            }.navigationTitle("Movies")
        }.onLoad(viewModel.load)
    }
}

private struct CarouselView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(movies) { movie in
                    CarouselItemView(movie: movie)
                }
            }.scrollTargetLayout()
        }.scrollTargetBehavior(.viewAligned)
    }
}

private struct CarouselItemView: View {
    let movie: Movie
    var body: some View {
        if let backdropImageURL = movie.backdropImageURL {
            NavigationLink(value: Screens.movie(movie.id)) {
                KFImage
                    .url(backdropImageURL)
                    .resizable()
                    .placeholder{ProgressView()}
                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .overlay(Text(movie.title).font(.system(size: 24, weight: .bold)).padding(16), alignment: .bottomLeading)
            }.foregroundColor(.white)
        }
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
