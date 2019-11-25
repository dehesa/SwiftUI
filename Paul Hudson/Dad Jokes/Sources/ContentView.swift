import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Joke.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Joke.setup, ascending: true)]) var jokes: FetchedResults<Joke>
    @State private var showingAddJoke = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.jokes, id: \.setup) { (joke) in
                    NavigationLink(destination: Text(joke.punchline)) {
                        EmojiView(for: joke.rating)
                        Text(joke.setup)
                    }
                }.onDelete(perform: self.removeJokes)
            }.navigationBarTitle("All Groan Up")
            .navigationBarItems(leading: EditButton(), trailing: Button("Add") { self.showingAddJoke.toggle() })
            .sheet(isPresented: self.$showingAddJoke) { AddView().environment(\.managedObjectContext, self.moc) }
        }
    }
    
    private func removeJokes(at offsets: IndexSet) {
        for index in offsets {
            let joke = jokes[index]
            moc.delete(joke)
        }
        try? moc.save()
    }
}

//struct ContentView: View {
//    @FetchRequest(entity: Joke.entity(), sortDescriptors: []) var jokes: FetchedResults<Joke>
//    @State var showingAddJoke = false
//    @Environment(\.managedObjectContext) var moc
//
//    var body: some View {
//        ZStack(alignment: .top) {
//            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(jokes, id: \.setup) { joke in
//                        JokeCard(joke: joke)
//                    }
//                }.padding()
//            }
//
//            Button("Add Joke") {
//                self.showingAddJoke.toggle()
//            }
//            .foregroundColor(.white)
//            .offset(y: 50)
//        }
//        .edgesIgnoringSafeArea(.all)
//        .sheet(isPresented: $showingAddJoke) {
//            AddView().environment(\.managedObjectContext, self.moc)
//        }
//    }
//
//    func removeJokes(at offsets: IndexSet) {
//        for index in offsets {
//            let joke = jokes[index]
//            moc.delete(joke)
//        }
//        try? moc.save()
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
