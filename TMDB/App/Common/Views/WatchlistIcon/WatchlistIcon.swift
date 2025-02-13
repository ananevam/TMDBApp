import SwiftUI

struct WatchlistIcon: View {
    @StateObject private var viewModel: WatchlistIconViewModel

    init(_ state: AccountState) {
        _viewModel = StateObject(wrappedValue: WatchlistIconViewModel(state))
    }
    var icon: String {
        viewModel.isWatchlist ? "bookmark.fill" : "bookmark"
    }
    var color: Color {
        viewModel.isWatchlist ? .blue : .gray
    }
    var body: some View {
        IconWrapper(action: viewModel.onTap) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: 16, height: 16)
        }
    }
}
