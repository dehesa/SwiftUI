// Example reworked from great SwiftUI Lab series of articles.
// Article 3: https://swiftui-lab.com/communicating-with-the-view-tree-part-3
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
    struct Element: Identifiable {
        let id = UUID()     // required when using ForEach later
        let kind: Kind
        let bounds: Anchor<CGRect>
        // Calculate the color to use in the minimap, for each view type
        func getColor() -> Color {
            switch kind {
            case .field(let length): return length == 0 ? .red : (length < 3 ? .yellow : .green)
            case .title: return .purple
            default: return .gray
            }
        }
        // Returns true, if this view type must be shown in the minimap. Only fields, field containers and the title are shown in the minimap
        func show() -> Bool {
            switch kind {
            case .field: return true
            case .title: return true
            case .fieldContainer: return true
            default: return false
            }
        }
    }
    
    enum Kind: Equatable {
        case formContainer  // main container
        case fieldContainer // contains a text label + text field
        case field(Int)     // text field (with an associated value that indicates the character count in the field)
        case title          // form title
        case miniMapArea    // view placed behind the minimap elements
    }
}

// MARK: -

struct RootView : View {
    @State private var values: [String] = .init(repeating: "", count: 5)
    @State private var length: Float = 360
    @State private var displayTwitterField = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                // This view puts a gray rectangle where the minimap elements will be.
                // We will reference its size and position later, to make sure the mini map elements are overlayed right on top of it.
                Color(white: 0.7)
                    .frame(width: 200)
                    .anchorPreference(key: Preference.self, value: .bounds) { [.init(kind: .miniMapArea, bounds: $0)] }
                    .padding(.horizontal, 30)
                // Form Container
                VStack(alignment: .leading) {
                    // Title
                    VStack {
                        Text("Hello \(self.values[0]) \(self.values[1]) \(self.values[2])")
                            .font(.title)
                            .fontWeight(.bold)
                            .anchorPreference(key: Preference.self, value: .bounds) { [.init(kind: .title, bounds: $0)]
                        }
                        Divider()
                    }
                    // Switch + Slider
                    HStack {
                        Toggle(isOn: self.$displayTwitterField) { EmptyView() }
                        Slider(value: self.$length, in: 360...540).layoutPriority(1)
                    }.padding(.bottom, 5)
                    // First row of text fields
                    HStack {
                        FieldView(text: self.$values[0], label: "First Name")
                        FieldView(text: self.$values[1], label: "Middle Name")
                        FieldView(text: self.$values[2], label: "Last Name")
                    }.frame(width: 540)
                    // Second row of text fields
                    HStack {
                        FieldView(text: self.$values[3], label: "Email")
                        if self.displayTwitterField {
                            FieldView(text: self.$values[4], label: "Twitter")
                        }
                    }.frame(width: CGFloat(self.length))
                }.transformAnchorPreference(key: Preference.self, value: .bounds) {
                    $0.append(.init(kind: .formContainer, bounds: $1))
                }
                Spacer()
            }.overlayPreferenceValue(Preference.self) { (value) in
                GeometryReader { MiniMapView(proxy: $0, preferences: value) }
            }
            Spacer()
        }.background(Color(white: 0.8))
        .edgesIgnoringSafeArea(.all)
    }
}
