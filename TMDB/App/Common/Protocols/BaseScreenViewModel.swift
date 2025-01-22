import SwiftUI

class BaseScreenViewModel<Data>: ObservableObject {
    @Published var state: State = .loading

    enum State {
        case loading
        case success(Data)
        case failure(String)
    }

    func execute<T>(request: @escaping (@escaping (Result<T, Error>) -> Void) -> Void, completion: @escaping (T) -> Void) {
        state = .loading

        request { [weak self] result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let err):
                self?.state = .failure(err.localizedDescription)
            }
        }
    }
}
