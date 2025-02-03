class ProfileScreenViewModel: BaseScreenViewModel<AccountResponse> {
    override func fetch() async throws -> AccountResponse {
        async let request = TMDBService.shared.getAccount()

        let account = try await request

        return account
    }
}
