/// - author: Brian Voong
/// - seealso: https://www.letsbuildthatapp.com
/// - seealso: https://www.youtube.com/watch?v=euGLqwOEpZE
import SwiftUI

/// The application root view composed of a navigation view with the scrollview displaying the movie titles.
struct RootView: View {
    private let topMovies = Movies.top
    private let animationMovies = Movies.animation
    
    var body: some View {
        NavigationView {
            ScrollView {
                MoviesCarousel(categoryName: "Top Movies of 2020", movies: self.topMovies)
                MoviesCarousel(categoryName: "Animated Movies", movies: self.animationMovies)
            }.navigationBarTitle("Movies of the Century", displayMode: .large)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
