import SwiftUI

struct ContentSectionView<Content: View>: View {
    let title: LocalizedStringKey
    let content: () -> Content
    init(title: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title).textStyle(.sectionTitle)
            content()
        }
    }
}
