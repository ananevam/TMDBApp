import SwiftUI
import Kingfisher

struct ActorScreen: View {
    @StateObject private var viewModel: ActorScreenViewModel

    init(id: Int) {
        _viewModel = StateObject(wrappedValue: ActorScreenViewModel(id: id))
    }

    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                ScrollView {
                    VStack(spacing: 16) {
                        KFImage.url(state.profileImageURL)
                            .resizable()
                            .placeholder { ProgressView() }
                            .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                            .padding(.horizontal, 100)
                        Text(state.name).font(.title)
                        VStack(alignment: .leading, spacing: 24) {
                            if let biography = state.biography {
                                MovieBlockView(title: "Biography") {
                                    Text(biography).font(.body)
                                }
                            }
                        }.padding(.horizontal, 16)
                    }
                }.navigationTitle(state.name).navigationBarTitleDisplayMode(.inline)
            }
        }.onLoad(viewModel.load)
    }
}
