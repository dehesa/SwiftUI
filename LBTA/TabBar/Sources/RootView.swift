/// - author: Brian Voong
/// - seealso: https://www.letsbuildthatapp.com
/// - seealso: https://www.youtube.com/watch?v=9lVLFlyaiq4
import SwiftUI

/// The main entrance to the application
struct RootView: View {
    /// Indicates the tab bar button being selected.
    @State private var selection: CustomTabView.Selection = .account
    /// Boolean indicating whether the target modal view should be displayed or not.
    @State private var shouldShowModal = false
    
    var body: some View {
        VStack(spacing: 0) {
            switch self.selection {
            case .account:
                NavigationView {
                    Text("First").navigationTitle("First Tab")
                }
            case .creation:
                ScrollView {
                    Text("TEST")
                }
            case .settings, .editor, .lasso:
                NavigationView {
                    Text("Remaining tabs")
                }
            }
            Divider()
            CustomTabView(selection: self.$selection, modal: self.$shouldShowModal)
        }.fullScreenCover(isPresented: self.$shouldShowModal) {
            Button { self.shouldShowModal.toggle() } label: { Text("Close modal") }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
