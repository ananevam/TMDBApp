import SwiftUI
import Kingfisher

struct MovieListItemView: View {
    let movie: Movie
    var body: some View {
        NavigationLink(value: Screens.movie(movie.id)) {
            HStack {
                if let posterPath = movie.posterPath {
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .frame(width: 50, height: 75)
                }
                Text(movie.title).layoutPriority(1)
                Spacer()
            }
        }
    }
}
