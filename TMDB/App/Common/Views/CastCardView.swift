import SwiftUI
import Kingfisher

struct CastCardView: View {
    let item: Actor
    var width: CGFloat?
    var body: some View {
        NavigationLink(value: Screens.actor(item.id)) {
            VStack {
                KFImage.url(item.profileImageURL)
                    .resizable()
                    .placeholder { ProgressView() }
                    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                    .cornerRadius(8)
                Text(item.name)
                    .textStyle(.cardTitle)
                    .font(.subheadline)
                    .lineLimit(2)
            }.frame(width: width)
        }.foregroundColor(.white)
    }
}
