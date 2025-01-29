import SwiftUI

struct ContentView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        TabView {
            NavigationStack {
                HomeScreen().navigationDestination(for: Screens.self, destination: screenDestination)
            }.tabItem {
                Label("Home", systemImage: "house.fill")
            }
            NavigationStack {
                TVScreen().navigationDestination(for: Screens.self, destination: screenDestination)
            }.tabItem {
                Label("TV", systemImage: "tv.fill")
            }
        }

    }
}
private func screenDestination(screen: Screens) -> some View {
    Group {
        switch screen {
        case .home:
            HomeScreen()
        case .movie(let movieId):
            MovieDetailScreen(movieId: movieId)
        case .genre(let genre):
            GenreScreen(genre: genre)
        case .tvShow(let tvShowId):
            TVDetailScreen()
        }
    }
}
