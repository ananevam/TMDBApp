import SwiftUI

struct ProfileTabScreen: View {
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        Group {
            if auth.isAuthenticated {
                ProfileScreen()
            } else {
                LoginScreen()
            }
        }
    }
}
