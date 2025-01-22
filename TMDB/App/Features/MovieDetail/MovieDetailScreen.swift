import SwiftUI

struct MovieDetailScreen: View {
    @StateObject private var viewModel: MovieDetailViewModel
    init(movieId: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }
    let colors: [Color] = [.red, .green, .blue]
    var body: some View {
        Group {
            LoadingErrorView(viewModel: viewModel) { (movie: MovieDetail) in
                ScrollView {
                    VStack(spacing: 16) {
                        poster(movie)
                        titleText(movie)
                        
                        if !movie.genres.isEmpty {
                            genres(movie)
                        }
                        rating(movie)
                        buttons()

                    }
                }.navigationTitle(movie.title).navigationBarTitleDisplayMode(.inline)
            }.task {
                viewModel.fetch()
            }
        }
    }
    
    private func poster(_ movie: MovieDetail) -> some View {
        Group {
            if let posterImageURL = movie.posterImageURL {
                AsyncImage(url: posterImageURL) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(height: 300)
                }.padding(.top)
            }
        }
    }
    
    private func titleText(_ movie: MovieDetail) -> some View {
        Group {
            Text(movie.title)
                .font(.title)
                .fontWeight(.bold)
                .padding([.leading, .trailing])
            Text(movie.overview)
                .font(.body)
                .padding([.leading, .trailing])
                .lineLimit(nil)
            Text("Release Date: \(movie.releaseDate)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding([.leading, .trailing])
        }
    }
    
    private func genres(_ movie: MovieDetail) -> some View {
        HStack {
            Text("Genres: ")
                .font(.subheadline)
                .foregroundColor(.gray)
            ForEach(movie.genres, id: \.id) { genre in
                Text(genre.name)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
    }
    
    private func rating(_ movie: MovieDetail) -> some View {
        Text("Rating: \(movie.voteAverage, specifier: "%.1f")")
            .font(.subheadline)
            .foregroundColor(.gray)
    }
    
    private func buttons() -> some View {
        HStack {
            Button(action: {
                // Action to add to favorites
            }) {
                Text("Add to Favorites")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            .padding([.leading, .trailing])
            
            Button(action: {
                // Action to watch the trailer
            }) {
                Text("Watch Trailer")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            .padding([.leading, .trailing])
        }
    }
}
