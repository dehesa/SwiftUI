// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/custom-styling
import SwiftUI

// MARK: - Style

/// Protocol to create your own visual representations of a `TrippleToggleView`.
protocol TripleToggleStyle {
    associatedtype Body: View
    typealias Configuration = TripleToggleView.StyleConfiguration
    
    func makeBody(configuration: Self.Configuration) -> Self.Body
}

extension TripleToggleStyle {
    func makeBodyTypeErased(configuration: Self.Configuration) -> AnyView {
        AnyView(self.makeBody(configuration: configuration))
    }
}

// MARK: - Style Configuration

extension TripleToggleView {
    struct StyleConfiguration {
        @Binding var state: State
        var label: Text
    }
}

// MARK: - View Extension

extension View {
    func tripleToggleStyle<S>(_ style: S) -> some View where S : TripleToggleStyle {
        self.environment(\.tripleToggleStyle, TripleToggleView.AnyStyle(style))
    }
}
