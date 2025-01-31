import SwiftUI

struct TextStyle {
    let font: Font

    init(size: Double, weight: Font.Weight = .regular) {
        self.font = .system(size: size, weight: weight)
    }
    static let sectionTitle = TextStyle(size: 22, weight: .bold)
    static let carouselTitle = TextStyle(size: 24, weight: .bold)
    static let cardTitle = TextStyle(size: 16)
}

struct TextStyleModifier: ViewModifier {
    private let style: TextStyle

    init(_ style: TextStyle) {
        self.style = style
    }

    func body(content: Content) -> some View {
        content.font(style.font)
    }
}

extension View {
    func textStyle(_ style: TextStyle) -> some View {
        modifier(TextStyleModifier(style))
    }
}
