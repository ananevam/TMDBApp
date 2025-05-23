import SwiftUI

struct ContentView: View {
    @EnvironmentObject var theme: ThemeManager
    @State var currentTab: TabBarTab = .home

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Group {
                    NavigationStack {
                        HomeScreen().navigationDestination(for: Screens.self, destination: screenDestination)
                    }.tag(TabBarTab.home)
                    NavigationStack {
                        TVScreen().navigationDestination(for: Screens.self, destination: screenDestination)
                    }.tag(TabBarTab.tv)
                    NavigationStack {
                        ProfileTabScreen().navigationDestination(for: Screens.self, destination: screenDestination)
                    }.tag(TabBarTab.profile)
                }.toolbar(.hidden, for: .tabBar)
            }.onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.shadowColor = .clear
                appearance.backgroundColor = UIColor(resource: .background)

                let backItemAppearance = UIBarButtonItemAppearance()
                backItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white] // fix text color
                appearance.backButtonAppearance = backItemAppearance
                let image = UIImage(systemName: "chevron.backward")?
                    .withTintColor(.white, renderingMode: .alwaysOriginal) // fix indicator color
                appearance.setBackIndicatorImage(image, transitionMaskImage: image)

                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
            }
            TabBar(currentTab: $currentTab)
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
            TVDetailScreen(tvShowId: tvShowId)
        case .actor(let id):
            ActorScreen(id: id)
        }
    }
}
