import SwiftUI
import Alamofire

class BaseScreenViewModel<Data>: ObservableObject {
    @Published var state: State = .loading

    enum State {
        case loading
        case success(Data)
        case failure(String)
    }

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
