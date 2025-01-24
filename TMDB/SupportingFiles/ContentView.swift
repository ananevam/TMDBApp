import SwiftUI

struct ContentView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                HomeScreen()
            }
        }
    }
}
