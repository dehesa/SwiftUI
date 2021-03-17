// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/scrollview-pull-to-refresh
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

struct RootView: View {
    @ObservedObject var model = Model()
    @State private var alternate: Bool = true
    
    let array = Array<String>(repeating: "Hello", count: 100)
    let transaction = Transaction(animation: .easeInOut(duration: 2.0))
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Dog Roulette")
            RefreshableScrollView(height: 70, refreshing: self.$model.loading) {
                DogView(dog: self.model.dog).padding(30).background(Color(UIColor.systemBackground))
            }.background(Color(UIColor.secondarySystemBackground))
        }
    }
}

private extension RootView {
    struct HeaderView: View {
        var title = ""
        
        var body: some View {
            VStack {
                Color(UIColor.systemBackground).frame(height: 30).overlay(Text(self.title))
                Color(white: 0.5).frame(height: 3)
            }
        }
    }
    
    struct DogView: View {
        let dog: Dog
        
        var body: some View {
            VStack {
                Image(self.dog.picture, defaultSystemImage: "questionmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 160)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .padding(2)
                    .overlay(Circle().strokeBorder(Color.black.opacity(0.1)))
                    .shadow(radius: 3)
                    .padding(4)
                
                Text(self.dog.name).font(.largeTitle).fontWeight(.bold)
                Text(self.dog.origin).font(.headline).foregroundColor(.blue)
                Text(self.dog.description)
                    .lineLimit(nil)
                    .frame(height: 1000, alignment: .top)
                    .padding(.top, 20)
            }
        }
    }
}

// MARK: -

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}


extension Image {
    init(_ name: String, defaultImage: String) {
        guard let img = UIImage(named: name) else { self.init(defaultImage); return }
        self.init(uiImage: img)
    }
    
    init(_ name: String, defaultSystemImage: String) {
        guard let img = UIImage(named: name) else { self.init(systemName: defaultSystemImage); return }
        self.init(uiImage: img)
    }
    
}
