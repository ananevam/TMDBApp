import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.loading {
                    ProgressView("Loading...")
                } else if let error = viewModel.error {
                    Text("Error \(error)")
                } else {
                    List(viewModel.movies) { movie in
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
            .navigationTitle("Популярные фильмы")
            .onAppear {
                viewModel.fetchPopularMovies()
            }
        }
    }
}
