import SwiftUI

class BaseScreenViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var error: String? = nil

    func execute<T>(request: @escaping (@escaping (Result<T, Error>) -> Void) -> Void, completion: @escaping (T) -> Void) {
        isLoading = true
        error = nil

        request { [weak self] result in
            sleep(1)
            self?.isLoading = false
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let err):
                self?.error = err.localizedDescription
            }
        }
    }
}
