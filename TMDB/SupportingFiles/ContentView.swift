import SwiftUI

struct ContentView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        NavigationStack {
            HomeScreen()
        }
    }
}
