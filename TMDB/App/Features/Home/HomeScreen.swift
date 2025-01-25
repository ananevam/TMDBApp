import SwiftUI
import Kingfisher

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModelAsync()
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        Screen {
            VStack {
                LoadingErrorView(viewModel: viewModel) { state in
                    List {
                        horizontalSection(title: "Popular movies", movies: state.popularMovies)
                        section(title: "Trending movies", movies: state.trendingMovies)
                    }.scrollContentBackground(.hidden)
                }
            }.navigationTitle("Movies")
        }.onLoad(viewModel.load)
    }
    
    private func horizontalSection(title: String, movies: [Movie]) -> some View {
        Section(header: Text(title)) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movies) { movie in
                        NavigationLink(value: Screens.movie(movie.id)) {
                            VStack {
                                if let posterPath = movie.posterPath {
                                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"))
                                        .placeholder {
                                            ProgressView()
                                        }
                                        .resizable()
                                        .frame(width: 120, height: 180)
                                        .cornerRadius(8)
                                }
                                Text(movie.title)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .frame(width: 120)
                            }
                        }
                    }
                }
            }
        }.listRowBackground(Color.clear)
    }
    
    private func section(title: String, movies: [Movie]) -> some View {
        Section(header: Text(title)) {
            ForEach(movies) { movie in
                NavigationLink(value: Screens.movie(movie.id)) {
                    HStack {
                        if let posterPath = movie.posterPath {
                            KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"))
                                .placeholder {
                                    ProgressView()
                                }
                                .resizable()
                                .frame(width: 50, height: 75)
                        }
                        Text(movie.title)
                    }
                }
            }
        }.listRowBackground(Color.clear)
    }
}
