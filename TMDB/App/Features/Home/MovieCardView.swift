import SwiftUI
import Kingfisher

struct MovieCardView: View {
    let movie: Movie
    var body: some View {
        NavigationLink(value: Screens.movie(movie.id)) {
            VStack(spacing: 0) {
                if let posterPath = movie.posterPath {
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                        .cornerRadius(12)
                }
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.system(size: 16))
                        .lineLimit(2)
                }.padding(16)
                Spacer()
            }.frame(width: (UIScreen.main.bounds.width - 16 * 5) / 2).background(Color(.cardBackground)).cornerRadius(12)
        }.foregroundColor(.white)
    }
}
