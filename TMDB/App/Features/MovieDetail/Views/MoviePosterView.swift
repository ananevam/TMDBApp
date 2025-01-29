import SwiftUI
import Kingfisher

struct MoviePosterView: View {
    let movie: MovieDetail
    var body: some View {
        Group {
            if let backdropImageURL = movie.backdropImageURL(.w1280) {
                KFImage
                    .url(backdropImageURL)
                    .resizable()
                    .placeholder {ProgressView()}
                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
            }
        }
    }
}
