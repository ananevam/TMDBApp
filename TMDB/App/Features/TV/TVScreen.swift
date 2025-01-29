import SwiftUI

struct TVScreen: View {
    @StateObject var viewModel = TVScreenViewModel()

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
                        ForEach(state) { movie in
                            MovieCardView(item: movie)
                        }
                    }
                }
                .navigationTitle("Trending TV Shows")
                .navigationBarTitleDisplayMode(.inline)
                .contentMargins(.horizontal, 16)

            }
        }.onLoad(viewModel.load)
    }
}
