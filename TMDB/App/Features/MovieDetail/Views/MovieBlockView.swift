import SwiftUI

struct MovieBlockView<Content: View>: View {
    let title: LocalizedStringKey
    let content: () -> Content
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.title2)
            content()
        }
    }
}
