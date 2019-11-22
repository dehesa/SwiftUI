// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/custom-styling
import SwiftUI

struct RootView: View {
    @State private var text = ""
    @State private var tripleState: TripleToggleView.State = .med
    
    var body: some View {
        VStack.init(spacing: 20) {
            Button("Tap Me!") { print("button pressed!") }
                .buttonStyle(SimpleButtonStyle(color: .blue))
            
            VStack(spacing: 10) {
                Text(self.text)
                Button("Tap Me!") { self.text = "Action Executed!" }
                    .buttonStyle(CustomButtonStyle(color: .red))
            }
            
            TripleToggleView(label: Text("Knob #1"), state: self.$tripleState)
            
            TripleToggleView(label: Text("Knob #2"), state: self.$tripleState)
                .tripleToggleStyle( KnobTripleToggleStyle(dotColor: .red) )
            
            TripleToggleView(label: Text("Knob #3"), state: self.$tripleState)
                .tripleToggleStyle(KnobTripleToggleStyle(dotColor: .black))
        }
    }
}

// MARK: -

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
