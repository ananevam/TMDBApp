import SwiftUI

struct MovieInfoView: View {
    let movie: Detailable
    let accountState: AccountState?
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading) {
                Text(movie.title).font(.title)
                Text([
                    movie.status,
                    movie.releaseYear,
                    movie.runtimeFormatted
                ].compactMap {$0}.joined(separator: " | ")).font(.footnote)
                Text("Rate: \(movie.voteAverage, specifier: "%.1f")").font(.footnote)
            }
            if let accountState = accountState {
                FavoriteIcon(accountState)
            }
            if let overview = movie.overview {
                MovieBlockView(title: "Synopsis") {
                    Text(overview).font(.body)
                }
            }
            if !movie.genres.isEmpty {
                MovieBlockView(title: "Genres") {
                    Text(movie.genres.map {$0.name}.joined(separator: ", "))
                }
            }
        }.frame(maxWidth: .infinity)
    }
}
