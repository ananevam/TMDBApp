import SwiftUI
import Kingfisher

struct CastCardView: View {
    let item: Actor
    var width: CGFloat?
    var body: some View {
        VStack {
            KFImage.url(item.profileImageURL)
                .resizable()
                .placeholder { ProgressView() }
                .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
            Text(item.name)
                .font(.subheadline)
                .lineLimit(2)
        }.frame(width: width)
    }
}
