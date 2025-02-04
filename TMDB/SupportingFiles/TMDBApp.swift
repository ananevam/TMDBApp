import SwiftUI

@main
struct TMDBApp: App {
    @StateObject private var theme = ThemeManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
                .environmentObject(AuthManager.shared)
        }
    }
}
