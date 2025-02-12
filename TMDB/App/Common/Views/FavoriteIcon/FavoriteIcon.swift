import SwiftUI

struct FavoriteIcon: View {
    @StateObject private var viewModel: FavoriteIconViewModel

    init(_ state: AccountState) {
        _viewModel = StateObject(wrappedValue: FavoriteIconViewModel(state))
    }
    var body: some View {
        Button(action: viewModel.onTap) {
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart") // Меняем иконку в зависимости от состояния
                .resizable()
                .scaledToFit()
                .foregroundColor(viewModel.isFavorite ? .red : .gray)
                .frame(width: 24, height: 24)
        }
    }
}
