import SwiftUI

struct HList<Content: View>: View {
    let content: (Double) -> Content
    private let width = (UIScreen.main.bounds.width - 16 * 5) / 2
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                content(width)
            }.fixedSize(horizontal: false, vertical: true)
        }.scrollClipDisabled()
    }
}
