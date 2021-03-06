// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/scrollview-pull-to-refresh
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

struct RefreshableScrollView<Content:View>: View {
    @State private var previousScrollOffset: CGFloat = 0
    @State private var scrollOffset: CGFloat = 0
    @State private var frozen: Bool = false
    @State private var rotation: Angle = .degrees(0)
    
    private var threshold: CGFloat = 80
    @Binding private var refreshing: Bool
    private let content: Content

    init(height: CGFloat = 80, refreshing: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.threshold = height
        self._refreshing = refreshing
        self.content = content()

    }
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack(alignment: .top) {
                    MovingView()
                    VStack { self.content }
                        .alignmentGuide(.top, computeValue: { d in (self.refreshing && self.frozen) ? -self.threshold : 0.0 })
                    SymbolView(height: self.threshold, loading: self.refreshing, frozen: self.frozen, rotation: self.rotation)
                }
            }.background(FixedView())
            .onPreferenceChange(Preference.self) { (values) in
                self.refreshLogic(values: values)
            }
        }
    }
    
    private func refreshLogic(values: [Preference.Element]) {
        DispatchQueue.main.async {
            // Calculate scroll offset
            let movingBounds = values.first { $0.view == .movingView }?.bounds ?? .zero
            let fixedBounds = values.first { $0.view == .fixedView }?.bounds ?? .zero
            
            self.scrollOffset  = movingBounds.minY - fixedBounds.minY
            self.rotation = self.symbolRotation(self.scrollOffset)
            // Crossing the threshold on the way down, we start the refresh process
            if !self.refreshing && (self.scrollOffset > self.threshold && self.previousScrollOffset <= self.threshold) {
                self.refreshing = true
            }
            
            if self.refreshing { // Crossing the threshold on the way up, we add a space at the top of the scrollview
                if self.previousScrollOffset > self.threshold && self.scrollOffset <= self.threshold {
                    self.frozen = true
                }
            } else { // remove the sapce at the top of the scroll view
                self.frozen = false
            }
            
            // Update last scroll offset
            self.previousScrollOffset = self.scrollOffset
        }
    }
    
    private func symbolRotation(_ scrollOffset: CGFloat) -> Angle {
        // We will begin rotation, only after we have passed
        // 60% of the way of reaching the threshold.
        if scrollOffset < self.threshold * 0.60 {
            return .degrees(0)
        } else {
            // Calculate rotation, based on the amount of scroll offset
            let h = Double(self.threshold)
            let d = Double(scrollOffset)
            let v = max(min(d - (h * 0.6), h * 0.4), 0)
            return .degrees(180 * v / (h * 0.4))
        }
    }
}

private extension RefreshableScrollView {
    struct MovingView: View {
        var body: some View {
            GeometryReader { (proxy) in
                Color.clear.preference(key: Preference.self, value: [.init(view: .movingView, bounds: proxy.frame(in: .global))])
            }.frame(height: 0)
        }
    }
    
    struct FixedView: View {
        var body: some View {
            GeometryReader { (proxy) in
                Color.clear.preference(key: Preference.self, value: [.init(view: .fixedView, bounds: proxy.frame(in: .global))])
            }
        }
    }
    
    struct SymbolView: View {
        var height: CGFloat
        var loading: Bool
        var frozen: Bool
        var rotation: Angle
        
        var body: some View {
            Group {
                if self.loading { // If loading, show the activity control
                    VStack {
                        Spacer()
                        ActivityRep()
                        Spacer()
                    }.frame(height: height).fixedSize()
                    .offset(y: -height + (self.loading && self.frozen ? height : 0.0))
                } else {
                    Image(systemName: "arrow.down") // If not loading, show the arrow
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: height * 0.25, height: height * 0.25).fixedSize()
                        .padding(height * 0.375)
                        .rotationEffect(rotation)
                        .offset(y: -height + (loading && frozen ? +height : 0.0))
                }
            }
        }
    }
}

// MARK: - Preferences

private struct Preference: PreferenceKey {
    static var defaultValue: [Element] = []

    static func reduce(value: inout [Element], nextValue: () -> [Element]) {
        value.append(contentsOf: nextValue())
    }
    
    struct Element: Equatable {
        let view: ViewType
        let bounds: CGRect
    }
}

private enum ViewType: Int {
    case movingView
    case fixedView
}

// MARK: - Helpers

private struct ActivityRep: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityRep>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityRep>) {
        uiView.startAnimating()
    }
}
