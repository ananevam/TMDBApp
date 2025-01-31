import SwiftUI

struct HListCastView: View {
    let items: [Actor]
    var body: some View {
        HList { width in
            ForEach(items) { item in
                CastCardView(item: item, width: width)
            }
        }
    }
}
