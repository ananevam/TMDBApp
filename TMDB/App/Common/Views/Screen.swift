import SwiftUI

struct Screen<Content: View>: View {
    let content: Content
    @EnvironmentObject var theme: ThemeManager
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            content
        }
    }
}
