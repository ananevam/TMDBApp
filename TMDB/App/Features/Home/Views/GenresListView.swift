import SwiftUI

struct GenresListView: View {
    let genres: [Genre]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(genres) { genre in
                    NavigationLink(value: Screens.genre(genre)) {
                        Text(genre.name.capitalizingFirstLetter())
                            .lineLimit(1)
                        .frame(height: 32)
                        .padding(.horizontal, 12)
                        .background(Color(.cardBackground))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    }
                }
            }
        }.scrollClipDisabled()
    }
}

#Preview {
    GenresListView(genres: [
        Genre(id: 1, name: "Thriller"),
        Genre(id: 2, name: "Action"),
        Genre(id: 3, name: "animation"),
        Genre(id: 4, name: "Adventure"),
        Genre(id: 5, name: "Comedy")
    ]).padding(.horizontal, 16)
}
