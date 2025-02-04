import SwiftUI
import Alamofire

struct LoginScreen: View {
    @EnvironmentObject var auth: AuthManager
    @StateObject private var viewModel = LoginScreenViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Login TMDB")
                .font(.title)
                .bold()
                .padding(.bottom, 16)

            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)

            TextField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)

            if viewModel.isLoading {
                ProgressView()
            } else {
                Button(action: {
                    viewModel.login()
                }, label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .padding(.horizontal)
                .opacity(viewModel.isDisabled ? 0.5 : 1)
                .disabled(viewModel.isDisabled)
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
