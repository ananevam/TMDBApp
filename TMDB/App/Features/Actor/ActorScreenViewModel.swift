import SwiftUI
import Alamofire

class ActorScreenViewModel: BaseScreenViewModel<Actor> {
    let id: Int

    init(id: Int) {
        self.id = id
    }

    override func fetch() async throws -> Actor {
        async let request = TMDBService.shared.getPerson(self.id)

        let actor = try await request

        return actor
    }
}
