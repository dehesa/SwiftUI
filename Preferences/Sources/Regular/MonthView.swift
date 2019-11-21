import SwiftUI

extension RootView {
    struct MonthView: View {
        let id: Int
        let label: String
        @Binding var activate: Int
        
        var body: some View {
            Text(self.label)
                .padding(10)
                .background(PreferenceSetter(id: self.id))
                .onTapGesture { self.activate = self.id }
        }
    }
}

extension RootView.MonthView {
    struct PreferenceSetter: View {
        let id: Int
        
        var body: some View {
            GeometryReader { (proxy) in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: RootView.Preference.self, value: [.init(viewId: self.id, rect: proxy.frame(in: .named("stackCoords")))])
            }
        }
    }
}
