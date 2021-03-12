// Series on Swift UI by Paul Hudson.
// Website: https://www.hackingwithswift.com
// Youtube: https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ
// Twitter: https://twitter.com/twostraws
import SwiftUI

@main struct Application: App {
    var order = Order()
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(self.order)
        }
    }
}
