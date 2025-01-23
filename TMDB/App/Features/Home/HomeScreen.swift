import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModelAsync()
    
    var body: some View {
        NavigationView {
            VStack {
                LoadingErrorView(viewModel: viewModel) { state in
                    List {
                        section(title: "Popular movies", movies: state.popularMovies)
                        section(title: "Trending movies", movies: state.trendingMovies)
                    }
                }
            }.navigationTitle("Movies")
        }.task {
            await viewModel.load()
        }
    }
    
    private func section(title: String, movies: [Movie]) -> some View {
        Section(header: Text(title)) {
            ForEach(movies) { movie in
                NavigationLink(destination: MovieDetailScreen(movieId: movie.id)) {
                    HStack {
                        if let posterPath = movie.posterPath {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 75)
                        }
                        Text(movie.title)
                    }
                }
            }
        }
    }
}
