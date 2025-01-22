import SwiftUI

struct MovieDetailScreen: View {
    @StateObject private var viewModel: MovieDetailViewModel
    init(movieId: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }
    var body: some View {
        NavigationView {
            LoadingErrorView(viewModel: viewModel) { movie in
                VStack {
                    Text(movie.title)
                    if let posterPath = movie.posterPath {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }.task {
            viewModel.fetch()
        }
    }
}
