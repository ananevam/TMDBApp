import SwiftUI
import Alamofire

class BaseScreenViewModel<Data>: ObservableObject {
    @Published var state: State = .loading

    enum State {
        case loading
        case success(Data)
        case failure(String)
    }
}

class BaseScreenViewModelClosure<Data>: BaseScreenViewModel<Data> {
    func execute<T>(request: @escaping (@escaping (DataResponse<T, AFError>) -> Void) -> Void, completion: @escaping (T) -> Void) {
        state = .loading

        request { [weak self] response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let err):
                self?.state = .failure(err.localizedDescription)
            }
        }
    }
}

class BaseScreenViewModelAsync<Data>: BaseScreenViewModel<Data> {
    @MainActor
    func load() async {
        state = .loading
        do {
            let result = try await fetch()
            self.state = .success(result)
        } catch let error {
            self.state = .failure(error.localizedDescription)
        }
    }
    public func fetch() async throws -> Data {
        fatalError("Method `fetch` must be overridden in a subclass")
    }
}
