import SwiftUI
import Kingfisher

struct MovieCardView: View {
    let movie: Movie
    var body: some View {
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
