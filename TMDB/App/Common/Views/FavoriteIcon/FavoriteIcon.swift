import SwiftUI

struct FavoriteIcon: View {
    @StateObject private var viewModel: FavoriteIconViewModel

    init(_ state: AccountState) {
        _viewModel = StateObject(wrappedValue: FavoriteIconViewModel(state))
    }
    var icon: String {
        viewModel.isFavorite ? "heart.fill" : "heart"
    }
    var color: Color {
        viewModel.isFavorite ? .red : .gray
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
