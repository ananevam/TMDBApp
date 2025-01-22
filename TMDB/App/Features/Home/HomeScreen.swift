import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                LoadingErrorView(viewModel: viewModel) { movies in
                    List(movies) { movie in
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
            }.navigationTitle("Популярные фильмы")
        }.task {
            viewModel.fetch()
        }
    }
}
