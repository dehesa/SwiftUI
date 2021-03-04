import Foundation

/// Representation of a movie within the data model.
struct Movie: Hashable {
    let title: String
    let imageName: String
}

struct Movies {
    static var top: [Movie] {
        [Movie(title: "Wonder Woman 1984", imageName: "ww1984"),
         Movie(title: "Avatar", imageName: "avatar"),
         Movie(title: "Captain Marvel", imageName: "captain_marvel"),
         Movie(title: "Soul", imageName: "soul"),
         Movie(title: "Tenet", imageName: "tenet"),
         Movie(title: "Avengers: Endgame", imageName: "avengers")]
    }
    
    static var animation: [Movie] {
        [Movie(title: "Soul", imageName: "soul"),
         Movie(title: "Tenet", imageName: "tenet"),
         Movie(title: "Avengers: Endgame", imageName: "avengers"),
         Movie(title: "Captain Marvel", imageName: "captain_marvel")]
    }
}
