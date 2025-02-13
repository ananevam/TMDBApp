import SwiftUI

struct IconWrapper<Content: View>: View {
    let action: @MainActor () -> Void
    let animationDuration = 0.1
    let content: () -> Content
    @State private var isPressed = false

    var scale: Double {
        isPressed ? 1.2 : 1.0
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(.tabBarBackground)
                .frame(width: 36, height: 36)
            Button(action: {
                withAnimation(.linear(duration: animationDuration)) {
                    isPressed = true
                }
                withAnimation(.linear(duration: animationDuration).delay(animationDuration)) {
                    isPressed = false
                }
                action()
            }, label: content).scaleEffect(scale)
        }
    }
}
