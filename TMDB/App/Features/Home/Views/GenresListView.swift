import SwiftUI

struct GenresListView: View {
    let genres: [Genre]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(genres) { genre in
                    Button(action: {
                        
                    }) {
                        Text(genre.name)
                            .lineLimit(1)
                    }
                    .frame(height: 32)
                    .padding(.horizontal, 12)
                    .background(Color(.cardBackground))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    GenresListView(genres: [
        Genre(id: 1, name: "Thriller"),
        Genre(id: 2, name: "Action"),
        Genre(id: 3, name: "Animation"),
        Genre(id: 4, name: "Adventure"),
        Genre(id: 5, name: "Comedy"),
    ])
}
