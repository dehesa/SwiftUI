// Series on Swift UI by Paul Hudson.
// Website: https://www.hackingwithswift.com
// Youtube: https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ
// Twitter: https://twitter.com/twostraws
import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
                }
            
            OrderView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Order")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        AppView()
            .environmentObject(self.order)
    }
}
