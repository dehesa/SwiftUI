/// - author: Brian Voong
/// - seealso: https://www.letsbuildthatapp.com
/// - seealso: https://www.youtube.com/watch?v=9lVLFlyaiq4
import SwiftUI

/// The custom tab view hosting 5 buttons.
struct CustomTabView: View {
    /// Indicates the tab bar button being selected.
    @Binding private var selection: Selection
    /// Boolean indicating whether the target modal view should be displayed or not.
    @Binding private var shouldShowModal: Bool
    
    init(selection: Binding<Selection>, modal: Binding<Bool>) {
        self._selection = selection
        self._shouldShowModal = modal
    }
    
    var body: some View {
        HStack {
            ForEach(Selection.allCases, id: \.self) { sel in
                Button {
                    self.selection = sel
                    if case .creation = sel { self.shouldShowModal.toggle() }
                } label: {
                    Spacer()
                    if case .creation = sel {
                        Image(systemName: sel.name)
                            .font(.system(size: 44, weight: .bold))
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: sel.name)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(self.selection == sel ? Color(.black) : Color(white: 0.8))
                    }
                    Spacer()
                }
            }
        }
    }
}

extension CustomTabView {
    /// All possible tab buttons.
    enum Selection: Int, Equatable, CaseIterable {
        case account
        case settings
        case creation
        case editor
        case lasso
        
        var name: String {
            switch self {
            case .account: return "person"
            case .settings: return "gear"
            case .creation: return "plus.app.fill"
            case .editor: return "pencil"
            case .lasso: return "lasso"
            }
        }
    }
}
