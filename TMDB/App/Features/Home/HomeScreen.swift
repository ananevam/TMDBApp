import SwiftUI
import Kingfisher

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModelAsync()
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                ScrollView {
                    VStack(alignment: .leading) {
                        ContentSectionView(title: "Popular movies") {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(state.popularMovies) { movie in
                                        MovieCardView(movie: movie)
                                    }
                                }
                            }
                        }
                        ContentSectionView(title: "Trending movies") {
                            ForEach(state.trendingMovies) { movie in
                                MovieListItemView(movie: movie)
                            }
                        }
                    }
                }.padding([.leading, .trailing], 16)
            }.navigationTitle("Movies")
        }.onLoad(viewModel.load)
    }

}
