import SwiftUI

struct RootView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Joke.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Joke.setup, ascending: true)]) var jokes: FetchedResults<Joke>
    @State private var isShowingAddModal = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.jokes, id: \.setup) { (joke) in
                    NavigationLink(destination: Text(joke.punchline)) {
                        EmojiView(for: joke.rating)
                        Text(joke.setup)
                    }
                }.onDelete(perform: self.removeJokes)
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                ToolbarItem(placement: .navigationBarTrailing) { Button("Add") { self.isShowingAddModal.toggle() } }
            }.sheet(isPresented: self.$isShowingAddModal) {
                AddView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

extension RootView {
    /// Removes a Joke from the database.
    /// - parameter offsets: The joke position within the table/database.
    private func removeJokes(at offsets: IndexSet) {
        for index in offsets {
            let joke = self.jokes[index]
            self.moc.delete(joke)
        }
        try? self.moc.save()
    }
}
