import SwiftUI
import Kingfisher

protocol MovieCardViewItem {
    var id: Int { get }
    var title: String { get }
    var posterPath: String? { get }
    func navigationLinkValue() -> Screens
}

struct MovieCardView: View {
    let item: MovieCardViewItem

    var width: CGFloat?
    var body: some View {
        NavigationLink(value: item.navigationLinkValue()) {
            VStack(alignment: .center, spacing: 0) {
                if let posterPath = item.posterPath {
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
                    Text(item.title)
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

#Preview("Horizontal") {
    HMoviesListView(movies: [
        Movie.example(title: "Title 1"),
        Movie.example(title: "Loooooooong Title 1"),
        Movie.example(title: "Title 1")
    ]).padding(.horizontal, 16)
    Spacer()
}

#Preview("Grid") {
    let movies = [
        Movie.example(title: "Title 1"),
        Movie.example(title: "Loooooooong Title 1"),
        Movie.example(title: "Title 1"),
    ]
    LazyVGrid(
        columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    ) {
        ForEach(movies) { movie in
            MovieCardView(item: movie, width: nil)
        }
    }
    Spacer()
}
