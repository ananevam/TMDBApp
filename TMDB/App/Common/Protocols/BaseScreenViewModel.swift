import SwiftUI
import Alamofire

class BaseScreenViewModel<Data>: ObservableObject {
    @Published var state: State = .loading

    enum State {
        case loading
        case success(Data)
        case failure(String)
    }

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
