import SwiftUI

struct TVScreen: View {
    @StateObject var viewModel = TVScreenViewModel()

    var body: some View {
        Screen {
            LoadingErrorView(viewModel: viewModel) { state in
                Text(state[0].name)
            }
        }.onLoad(viewModel.load)
    }
}
