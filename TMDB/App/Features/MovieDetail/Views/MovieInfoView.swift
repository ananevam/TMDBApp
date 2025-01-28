import SwiftUI

struct MovieInfoView: View {
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
