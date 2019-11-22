// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/custom-styling
import SwiftUI

struct TripleToggleView: View {
    @Environment(\.tripleToggleStyle) var style: TripleToggleView.AnyStyle
    let label: Text
    @Binding var state: State
    
    var body: some View {
        let configuration = StyleConfiguration(state: self._state, label: label)
        return style.makeBody(configuration: configuration)
    }
}

extension TripleToggleView {
    enum State: Int {
        case low
        case med
        case high
    }
}

// MARK: - Custom Environment Key

extension TripleToggleView {
    struct Key: EnvironmentKey {
        static let defaultValue: TripleToggleView.AnyStyle = .init(DefaultTripleToggleStyle())
    }
}

extension EnvironmentValues {
    var tripleToggleStyle: TripleToggleView.AnyStyle {
        get { self[TripleToggleView.Key.self] }
        set { self[TripleToggleView.Key.self] = newValue }
    }
}
