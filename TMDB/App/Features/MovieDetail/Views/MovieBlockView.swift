import SwiftUI

struct MovieBlockView<Content: View>: View {
    let title: String
    let content: () -> Content
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.title2)
            content()
        }
    }
}
