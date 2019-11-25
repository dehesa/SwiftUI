import SwiftUI

struct EmojiView: View {
    var rating: String
    
    init(for rating: String) {
        self.rating = rating
    }
    
    var body: some View {
        switch rating {
        case "Sob": return Text("😭")
        case "Sigh": return Text("😔")
        case "Smirk": return Text("😏")
        default: return Text("😐")
        }
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(for: "Sob")
    }
}
