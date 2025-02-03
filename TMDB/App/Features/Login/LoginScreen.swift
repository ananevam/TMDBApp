import SwiftUI
import Alamofire

struct LoginScreen: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Вход в TMDB")
                .font(.title)
                .bold()
                .padding(.bottom, 16)

            TextField("Логин", text: $authViewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)

            TextField("Пароль", text: $authViewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)

            if authViewModel.isLoading {
                ProgressView()
            } else {
                Button(action: {
                    authViewModel.login()
                }) {
                    Text("Войти")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(authViewModel.username.isEmpty || authViewModel.password.isEmpty)
            }

            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 8)
            }

            Spacer()
        }
        .padding()
    }
}
struct RequestTokenResponse: Decodable {
    let success: Bool
    let requestToken: String
    let expiresAt: String

    enum CodingKeys: String, CodingKey {
        case success
        case requestToken = "request_token"
        case expiresAt = "expires_at"
    }
}
