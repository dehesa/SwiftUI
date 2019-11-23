// Example reworked from great SwiftUI Lab series of articles.
// Article 1: https://swiftui-lab.com/communicating-with-the-view-tree-part-1
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

struct RootView : View {
    @State private var activeMonth: Int = 0
    @State private var rects: [CGRect] = .init(repeating: .init(), count: 12)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3.0)
                .foregroundColor(Color.green)
                .frame(width: self.rects[self.activeMonth].size.width, height: self.rects[self.activeMonth].size.height)
                .offset(x: self.rects[self.activeMonth].minX, y: self.rects[self.activeMonth].minY)
                .animation(.easeInOut(duration: 1.0))
            
            VStack {
                Spacer()
                HStack {
                    MonthView(id: 0, label: "January", activate: self.$activeMonth)
                    MonthView(id: 1, label: "February", activate: self.$activeMonth)
                    MonthView(id: 2, label: "March", activate: self.$activeMonth)
                    MonthView(id: 3, label: "April", activate: self.$activeMonth)
                }
                Spacer()
                HStack {
                    MonthView(id: 4, label: "May", activate: self.$activeMonth)
                    MonthView(id: 5, label: "June", activate: self.$activeMonth)
                    MonthView(id: 6, label: "July", activate: self.$activeMonth)
                    MonthView(id: 7, label: "August", activate: self.$activeMonth)
                }
                Spacer()
                HStack {
                    MonthView(id: 8, label: "September", activate: self.$activeMonth)
                    MonthView(id: 9, label: "October", activate: self.$activeMonth)
                    MonthView(id: 10, label: "November", activate: self.$activeMonth)
                    MonthView(id: 11, label: "December", activate: self.$activeMonth)
                }
                Spacer()
            }.onPreferenceChange(Preference.self) { (value) in
                for element in value {
                    self.rects[element.viewId] = element.rect
                }
            }
        }.coordinateSpace(name: "stackCoords")
    }
}

// MARK: - Preferences

extension RootView {
    struct Preference: PreferenceKey {
        static var defaultValue: [Element] = []
        
        static func reduce(value: inout [Element], nextValue: () -> [Element]) {
            value.append(contentsOf: nextValue())
        }
    }
}

extension RootView.Preference {
    struct Element: Equatable {
        let viewId: Int
        let rect: CGRect
    }
}

// MARK: -

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
