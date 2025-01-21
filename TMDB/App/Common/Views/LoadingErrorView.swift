import SwiftUI

struct LoadingErrorView<Content: View>: View {
    var viewModel: BaseScreenViewModel
    let content: () -> Content

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.error {
                Text("Error \(error)")
            } else {
                content()
            }
        }
    }
}
