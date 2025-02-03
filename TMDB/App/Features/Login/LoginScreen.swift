import SwiftUI
import Alamofire

struct LoginScreen: View {
    @StateObject var viewModel = LoginScreenViewModel()
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Вход в TMDB")
                .font(.title)
                .bold()
                .padding(.bottom, 16)

            TextField("Логин", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)

            TextField("Пароль", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)

            if viewModel.isLoading {
                ProgressView()
            } else {
                Button(action: {
                    viewModel.login {
                        userViewModel.checkSession()
                    }
                }) {
                    Text("Войти")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 8)
            }

            Spacer()
        }
        .padding()
    }
}
