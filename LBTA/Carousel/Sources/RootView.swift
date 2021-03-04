/// - author: Brian Voong
/// - seealso: https://www.letsbuildthatapp.com
/// - seealso: https://www.youtube.com/watch?v=euGLqwOEpZE
import SwiftUI

/// The application root view composed of a navigation view with the scrollview displaying the movie titles.
struct RootView: View {
    let topMovies = Movies.top
    let animationMovies = Movies.animation
    
    var body: some View {
        NavigationView {
            ScrollView {
                MoviesCarousel(categoryName: "Top Movies of 2020", movies: topMovies)
                MoviesCarousel(categoryName: "Animated Movies", movies: animationMovies)
            }.navigationBarTitle("Movies of the Century", displayMode: .large)
        }
    }
}

/// View with a title and a list of movies.
struct MoviesCarousel: View {
    let categoryName: String
    let movies: [Movie]
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 125
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 125
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        return scale
    }
    
    var body: some View {
        HStack {
            Text(categoryName)
                .font(.system(size: 14, weight: .heavy))
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(2)
            Spacer()
        }.padding(.horizontal)
        .padding(.top)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(movies, id: \.self) { num in
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        NavigationLink(
                            destination: MovieDetailsView(movie: num),
                            label: {
                                VStack(spacing: 8) {
                                    Image(num.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180)
                                        .clipped()
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(white: 0.4))
                                        )
                                        .shadow(radius: 3)
                                    Text(num.title)
                                        .font(.system(size: 16, weight: .semibold))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                    HStack(spacing: 0) {
                                        ForEach(0..<5) { num in
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.orange)
                                                .font(.system(size: 14))
                                        }
                                    }.padding(.top, -4)
                                }
                            }).scaleEffect(.init(width: scale, height: scale))
                            .animation(.easeOut(duration: 1))
                            .padding(.vertical)
                    }.frame(width: 125, height: 400)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 32)
                }
                
                Spacer()
                    .frame(width: 16)
            }
        }
    }
}

struct MovieDetailsView: View {
    let movie: Movie
    
    var body: some View {
        Image(movie.imageName)
            .resizable()
            .scaledToFill()
            .navigationTitle(movie.title)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
