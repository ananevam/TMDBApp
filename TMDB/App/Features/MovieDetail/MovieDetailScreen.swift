import SwiftUI

struct MovieDetailScreen: View {
    @StateObject private var viewModel: MovieDetailViewModel
    @EnvironmentObject var theme: ThemeManager
    init(movieId: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }
    let colors: [Color] = [.red, .green, .blue]
    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { (movie: MovieDetail) in
                ScrollView {
                    VStack(spacing: 16) {
                        MoviePosterView(movie: movie)
                        MovieInfoView(movie: movie)
                    }
                }.navigationTitle(movie.title).navigationBarTitleDisplayMode(.inline)
            }
        }.onLoad(viewModel.fetch)
    }
}

private struct MoviePosterView: View {
    let movie: MovieDetail
    var body: some View {
        Group {
            if let backdropImageURL = movie.backdropImageURL {
                AsyncImage(url: backdropImageURL) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 320)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(height: 320)
                }
            }
        }
    }
    
}
private struct MovieBlockView<Content: View>: View {
    let title: String
    let content: () -> Content
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.title3)
            content()
        }
    }
}
private struct MovieInfoView: View {
    let movie: MovieDetail
    var body: some View {
        VStack {
            VStack {
                Text(movie.title).font(.title)
                Text([
                    movie.status,
                    movie.releaseYear,
                    movie.runtimeFormatted
                ].compactMap{$0}.joined(separator: " | "))
                Text("Rate: \(movie.voteAverage, specifier: "%.1f")")
            }
            MovieBlockView(title: "Synopsis") {
                Text(movie.overview).font(.body)
            }
            if !movie.genres.isEmpty {
                MovieBlockView(title: "Genres") {
                    Text(movie.genres.map{$0.name}.joined(separator: ", "))
                }
            }
        }
    }
}
