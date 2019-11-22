// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/custom-styling
import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    #if os(iOS)
    let width: CGFloat = 50
    #else
    let width: CGFloat = 38
    #endif
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            
            #if os(iOS)
            Spacer()
            #endif
            
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: width, height: width / 2)
                    .foregroundColor(configuration.isOn ? .green : .red)
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: (width / 2) - 4, height: width / 2 - 6)
                    .padding(4)
                    .foregroundColor(.white)
                    .onTapGesture { withAnimation { configuration.$isOn.wrappedValue.toggle() }
                }
            }
        }.accessibility(activationPoint: configuration.isOn ? UnitPoint(x: 0.25, y: 0.5) : UnitPoint(x: 0.75, y: 0.5))
        .alignmentGuide(.leading, computeValue: { d in (d.width - self.width) })
    }
}

// MARK: -

struct CustomToggle_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
    
    private struct PreviewView: View {
        @State private var flag = true

        var body: some View {
            VStack {
                Toggle(isOn: $flag) { Text("Custom Toggle") }
            }.toggleStyle( CustomToggleStyle() )
        }
    }
}
