import SwiftUI

struct ContentSectionView<Content: View>: View {
    let title: String
    let content: () -> Content
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.system(size: 22, weight: .bold))
            content()
        }
    }
}

