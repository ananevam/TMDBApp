import SwiftUI

@main
struct TMDBApp: App {
    @StateObject private var theme = ThemeManager()
    @StateObject private var userViewModel = UserViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
                .environmentObject(userViewModel)
        }
    }
}
