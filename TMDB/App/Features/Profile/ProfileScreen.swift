import SwiftUI
import Kingfisher

struct ProfileScreen: View {

    @EnvironmentObject var auth: AuthManager
    @StateObject var viewModel = ProfileScreenViewModel()
    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            if let user = auth.user {
                                KFImage.url(user.gravatarImageURL)
                                    .resizable()
                                    .placeholder { ProgressView() }
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(maxWidth: geometry.size.width * (1 / 2))

                                Text(user.username)
                                    .font(.title)

                                Button("Выйти") {
                                    auth.logout()
                                }
                                .padding()
                            } else {
                                Text("Ошибка загрузки профиля")
                            }
                            if !state.favoriteMovies.isEmpty {
                                ContentSectionView(title: "Favorite Movies") {
                                    HListMoviesView(movies: state.favoriteMovies)
                                }
                            }
                        }.frame(maxWidth: .infinity).padding(.horizontal, 16)
                    }
                }
            }
        }.onLoad(viewModel.load)
    }
}
