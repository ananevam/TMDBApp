import SwiftUI

enum CustomColors: String {
    case bg = "Background"
}

class ThemeManager: ObservableObject {
    let background = Color(.bg)
}
