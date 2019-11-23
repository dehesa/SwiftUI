// Example reworked from great SwiftUI Lab series of articles.
// Article 2: https://swiftui-lab.com/communicating-with-the-view-tree-part-2
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

extension RootView {
    struct Preference: PreferenceKey {
        static var defaultValue: [Element] = []
        
        static func reduce(value: inout [Element], nextValue: () -> [Element]) {
            value.append(contentsOf: nextValue())
        }
    }
}

extension RootView.Preference {
    struct Element {
        let viewId: Int
        let bounds: Anchor<CGRect>
    }
}

// MARK: -

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
            }.backgroundPreferenceValue(Preference.self) { (value) in
                GeometryReader { (proxy) in
                    ZStack {
                        Self.makeBorder(proxy: proxy, preference: value, activeMonth: self.activeMonth)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }.coordinateSpace(name: "stackCoords")
    }
}

// MARK: -

extension RootView {
    static func makeBorder(proxy: GeometryProxy, preference: Preference.Value, activeMonth id: Int) -> some View {
        let bounds: CGRect = preference.first { $0.viewId == id }.map { proxy[$0.bounds] } ?? .zero
        return RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3.0)
                .foregroundColor(Color.green)
                .frame(width: bounds.size.width, height: bounds.size.height)
                .fixedSize()
                .offset(x: bounds.minX, y: bounds.minY)
                .animation(.easeInOut(duration: 1.0))
    }
}

extension RootView {
    struct MonthView: View {
        let id: Int
        let label: String
        @Binding var activate: Int
        
        var body: some View {
            Text(self.label)
                .padding(10)
                .anchorPreference(key: Preference.self, value: .bounds, transform: { [.init(viewId: self.id, bounds: $0)] })
                .onTapGesture { self.activate = self.id }
        }
    }
}
