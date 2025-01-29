import SwiftUI
import Kingfisher

struct CarouselView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(movies) { movie in
                    CarouselItemView(movie: movie)
                }
            }.scrollTargetLayout()
        }.scrollTargetBehavior(.viewAligned)
    }
}

private struct CarouselItemView: View {
    let movie: Movie
    var body: some View {
        if let backdropImageURL = movie.backdropImageURL {
            NavigationLink(value: Screens.movie(movie.id)) {
                KFImage
                    .url(backdropImageURL)
                    .resizable()
                    .placeholder {ProgressView()}
                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .overlay(
                        Text(movie.title).font(.system(size: 24, weight: .bold)).padding(16),
                        alignment: .bottomLeading
                    )
            }.foregroundColor(.white)
        }
    }
}
