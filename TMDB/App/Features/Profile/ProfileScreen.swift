import SwiftUI

struct ProfileScreen: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            if let user = authViewModel.user {
                Text("Привет, \(user.username)")
                    .font(.title)

                if let avatarPath = user.avatar.tmdb.avatarPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(avatarPath)")) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                }

                Button("Выйти") {
                    authViewModel.logout()
                }
                .padding()
            } else {
                Text("Ошибка загрузки профиля")
            }
        }
    }
}
