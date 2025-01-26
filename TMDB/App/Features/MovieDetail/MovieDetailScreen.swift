import SwiftUI
import Kingfisher

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
                        VStack {
                            MovieInfoView(movie: movie)
                        }.padding(.horizontal, 16)
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
            if let backdropImageURL = movie.backdropImageURL(.w1280) {
                KFImage
                    .url(backdropImageURL)
                    .resizable()
                    .placeholder{ProgressView()}
                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
            }
        }
    }
    
}
private struct MovieBlockView<Content: View>: View {
    let title: String
    let content: () -> Content
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.title2)
            content()
        }
    }
}
private struct MovieInfoView: View {
    let movie: MovieDetail
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading) {
                Text(movie.title).font(.title)
                Text([
                    movie.status,
                    movie.releaseYear,
                    movie.runtimeFormatted
                ].compactMap{$0}.joined(separator: " | ")).font(.footnote)
                Text("Rate: \(movie.voteAverage, specifier: "%.1f")").font(.footnote)
            }
            MovieBlockView(title: "Synopsis") {
                Text(movie.overview).font(.body)
            }
            if !movie.genres.isEmpty {
                MovieBlockView(title: "Genres") {
                    Text(movie.genres.map{$0.name}.joined(separator: ", "))
                }
            }
        }.frame(maxWidth: .infinity)
    }
}
