// Series on Swift UI by Paul Hudson.
// Website: https://www.hackingwithswift.com
// Youtube: https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ
// Twitter: https://twitter.com/twostraws
import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(self.order.items) { (item) in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }.onDelete(perform: self.deleteItems)
                }
                
                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text("Place Order")
                    }
                }.disabled(self.order.items.isEmpty)
            }.listStyle(GroupedListStyle())
            .navigationBarTitle("Order")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        self.order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        OrderView()
            .environmentObject(self.order)
    }
}
