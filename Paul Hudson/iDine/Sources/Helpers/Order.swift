// Series on Swift UI by Paul Hudson.
// Website: https://www.hackingwithswift.com
// Youtube: https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ
// Twitter: https://twitter.com/twostraws
import SwiftUI

final class Order: ObservableObject {
    @Published var items = [MenuItem]()

    var total: Int {
        guard items.count > 0 else { return 0 }
        return items.reduce(0) { $0 + $1.price }
    }

    func add(item: MenuItem) {
        items.append(item)
    }

    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}
