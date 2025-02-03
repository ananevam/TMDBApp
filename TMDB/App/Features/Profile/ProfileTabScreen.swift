import SwiftUI

struct ProfileTabScreen: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                ProfileScreen(authViewModel: authViewModel)
            } else {
                LoginScreen(authViewModel: authViewModel)
            }
        }
        .onAppear {
            authViewModel.checkSession()
        }
    }
}
