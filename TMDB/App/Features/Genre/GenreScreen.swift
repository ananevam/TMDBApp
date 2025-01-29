import SwiftUI
import Kingfisher

struct GenreScreen: View {
    @StateObject private var viewModel: GenreViewModel
    @EnvironmentObject var theme: ThemeManager
    init(genre: Genre) {
        _viewModel = StateObject(wrappedValue: GenreViewModel(genre: genre))
    }

    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        ForEach(state.movies) { movie in
                            MovieCardView(movie: movie)
                        }
                    }
                }
                .navigationTitle(state.genre.name.capitalizingFirstLetter())
                .navigationBarTitleDisplayMode(.inline)
                .contentMargins(.horizontal, 16)
            }
        }.onLoad(viewModel.load)
    }
}
