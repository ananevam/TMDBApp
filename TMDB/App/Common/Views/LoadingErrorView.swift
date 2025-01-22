import SwiftUI

struct LoadingErrorView<T, Content: View>: View {
    @ObservedObject var viewModel: BaseScreenViewModel<T>
    let content: (T) -> Content

    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading...")
        case .failure(let error):
            Text("Error \(error)")
        case .success(let result):
            content(result)
        }
    }
}
