import SwiftUI

struct ProfileTabScreen: View {
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        Group {
            switch auth.state {
            case .loggedIn:
                ProfileScreen()
            case .notLoggedIn:
                LoginScreen()
            }
        }
    }
}
