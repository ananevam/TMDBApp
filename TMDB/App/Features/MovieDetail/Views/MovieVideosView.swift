import SwiftUI
import Kingfisher

struct MovieVideosView: View {
    let videos: [MovieVideo]

    var body: some View {
        let width = UIScreen.main.bounds.width / 2
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(videos) { video in
                    MovieVideoView(video: video, width: width)
                }
            }
        }.scrollClipDisabled()
    }
}

struct MovieVideoView: View {
    let video: MovieVideo
    var width: CGFloat?
    var body: some View {
        return Link(destination: video.youtubeURL) {
            VStack {
                KFImage.url(video.thumbnailURL)
                    .resizable()
                    .placeholder { ProgressView() }
                    .aspectRatio(4/3, contentMode: .fill)
                Text(video.name)
                    .font(.subheadline)
                    .lineLimit(2)
            }.frame(width: width)
        }
    }
}
