import SwiftUI

struct RootView: View {
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
            }.navigationBarItems(leading: EditButton(), trailing: Button("Add") { self.showingAddJoke.toggle() })
            .sheet(isPresented: self.$showingAddJoke) { AddView().environment(\.managedObjectContext, self.moc) }
        }
    }
}

extension RootView {
    /// Removes a Joke from the database.
    /// - parameter offsets: The joke position within the table/database.
    private func removeJokes(at offsets: IndexSet) {
        for index in offsets {
            let joke = jokes[index]
            moc.delete(joke)
        }
        try? moc.save()
    }
}
