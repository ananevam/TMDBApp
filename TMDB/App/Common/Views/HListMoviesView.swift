import SwiftUI

struct HListMoviesView: View {
    let movies: [Movie]
    var body: some View {
        HList { width in
            ForEach(movies) { movie in
                MovieCardView(item: movie, width: width)
            }
        }
    }
}
