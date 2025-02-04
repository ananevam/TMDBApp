import SwiftUI

struct ProfileTabScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        Group {
            if userViewModel.isAuthenticated {
                ProfileScreen()
            } else {
                LoginScreen()
            }
        }
    }
}
