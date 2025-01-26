import SwiftUI
import Kingfisher

struct MovieCardView: View {
    let movie: Movie
    var width = (UIScreen.main.bounds.width - 16 * 5) / 2
    var body: some View {
        NavigationLink(value: Screens.movie(movie.id)) {
            VStack(alignment: .center, spacing: 0) {
                if let posterPath = movie.posterPath {
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                        // .cornerRadius(12)
                        // .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))
                        .layoutPriority(1)
                }
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.system(size: 16))
                        .lineLimit(2)
                }.padding(16)
            }.frame(
                minWidth: width,
                idealWidth: width,
                maxWidth: width,
                maxHeight: .infinity,
                alignment: .top
            )
                .background(Color(.cardBackground))
                .cornerRadius(12)
        }.foregroundColor(.white)
    }
}

#Preview {
    HMoviesListView(movies: [
        Movie.example(title: "Title 1"),
        Movie.example(title: "Loooooooong Title 1"),
        Movie.example(title: "Title 1")
    ]).padding(.horizontal, 16)
    Spacer()
}
