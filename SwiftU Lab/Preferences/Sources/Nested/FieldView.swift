// Example reworked from great SwiftUI Lab series of articles.
// Article 3: https://swiftui-lab.com/communicating-with-the-view-tree-part-3
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

extension RootView {
    // This view draws a rounded box, with a label and a textfield
    struct FieldView: View {
        @Binding var text: String
        let label: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(self.label)
                TextField("", text: self.$text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .anchorPreference(key: Preference.self, value: .bounds) { [.init(kind: .field(self.text.count), bounds: $0)] }
            }.padding(15)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color(white: 0.9)))
            .transformAnchorPreference(key: Preference.self, value: .bounds) { $0.append(.init(kind: .fieldContainer, bounds: $1)) }
        }
    }
}
