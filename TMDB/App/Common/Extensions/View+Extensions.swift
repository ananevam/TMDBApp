import SwiftUI

private struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: () async -> Void

    init(action: @escaping () async -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.task {
            if didLoad == false {
                await action()
                didLoad = true
            }
        }
    }
}

extension View {
    func onLoad(_ action: @escaping () async -> Void) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }
}

