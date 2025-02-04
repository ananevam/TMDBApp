import SwiftUI
import Kingfisher

struct ProfileScreen: View {
    @EnvironmentObject var auth: AuthManager
    @StateObject var viewModel = ProfileScreenViewModel()

    var body: some View {
        guard case let .loggedIn(user, _) = auth.state else {
            return AnyView(Text("Not logged in"))
        }
        return AnyView(
            Screen {
                LoadingErrorView(viewModel: viewModel) { state in
                    GeometryReader { geometry in
                        ScrollView {
                            VStack {
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
        )
    }
}
