// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/custom-styling
import SwiftUI

struct CustomButtonStyle: PrimitiveButtonStyle {
    var color: Color

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        CustomButton(configuration: configuration, color: color)
    }
}

private extension CustomButtonStyle {
    struct CustomButton: View {
        @GestureState private var pressed = false
        
        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color
        
        var body: some View {
            let longPress = LongPressGesture(minimumDuration: 1.0, maximumDistance: 0.0)
                .updating($pressed) { value, state, _ in state = value }
                .onEnded { _ in self.configuration.trigger() }
            
            return configuration.label
                .foregroundColor(.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(pressed ? 0.5 : 1.0)
                .scaleEffect(pressed ? 0.8 : 1.0)
                .gesture(longPress)
        }
    }
}

// MARK: -

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
    
    private struct PreviewView: View {
        @State private var text = ""
        
        var body: some View {
            VStack(spacing: 20) {
                Text(self.text)
                Button("Tap Me!") { self.text = "Action Executed!" }
                    .buttonStyle(CustomButtonStyle(color: .red))
            }
        }
    }
}
