import SwiftUI

struct ContentView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        NavigationStack {
            HomeScreen().navigationDestination(for: Screens.self) { screen in
                switch screen {
                case .home:
                    HomeScreen()
                case .movie(let movieId):
                    MovieDetailScreen(movieId: movieId)
                case .genre(let genre):
                    GenreScreen(genre: genre)
                }
            }
        }
    }
}
