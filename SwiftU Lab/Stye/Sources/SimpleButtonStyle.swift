// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/custom-styling
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    var color: Color = .green
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5).fill(color))
            .compositingGroup()
            .shadow(color: .black, radius: 3)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
    }
}

// MARK: -

struct SimpleButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Tap Me!") { print("button pressed!") }
            .buttonStyle(SimpleButtonStyle(color: .blue))
    }
}
