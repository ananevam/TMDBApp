import SwiftUI

struct MovieDetailScreen: View {
    let movie: Movie
    var body: some View {
        NavigationView {
            if let posterPath = movie.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            }
        }.navigationTitle(movie.title)
    }
}
