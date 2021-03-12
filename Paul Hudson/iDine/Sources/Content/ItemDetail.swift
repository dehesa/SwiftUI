// Series on Swift UI by Paul Hudson.
// Website: https://www.hackingwithswift.com
// Youtube: https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ
// Twitter: https://twitter.com/twostraws
import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order: Order
    var item: MenuItem
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(self.item.mainImage)
                Text("Photo: \(self.item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            Text(self.item.description)
                .padding()
            
            Button("Order This") {
                self.order.add(item: self.item)
            }.font(.headline)
            
            Spacer()
        }.navigationBarTitle(Text(self.item.name), displayMode: .inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example)
                .environmentObject(self.order)
        }
    }
}
