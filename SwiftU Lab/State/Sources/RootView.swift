// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/state-changes
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

struct RootView: View {
    @State private var flag = false
    @State private var cardinalDirection = ""
    
    var body: some View {
        return VStack(spacing: 30) {
            CPUWheelView().frame(height: 150)
            
            Text("\(cardinalDirection)").font(.largeTitle)
            Image(systemName: "location.north")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .modifier(RotateNeedle(cardinalDirection: self.$cardinalDirection, angle: self.flag ? 0 : 360))
            
            Button("Animate") {
                withAnimation(.easeInOut(duration: 3.0)) { self.flag.toggle() }
            }
        }
    }
}

struct RotateNeedle: GeometryEffect {
    @Binding var cardinalDirection: String
    var angle: Double
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            self.cardinalDirection = self.angleToString(self.angle)
        }
        
        let rotation = CGAffineTransform(rotationAngle: CGFloat(angle * (Double.pi / 180.0)))
        let offset1 = CGAffineTransform(translationX: size.width/2.0, y: size.height/2.0)
        let offset2 = CGAffineTransform(translationX: -size.width/2.0, y: -size.height/2.0)
        return ProjectionTransform(offset2.concatenating(rotation).concatenating(offset1))
    }
    
    private func angleToString(_ a: Double) -> String {
        switch a {
        case 315..<405: fallthrough
        case 0..<45:    return "North"
        case 45..<135:  return "East"
        case 135..<225: return "South"
        default: return "West"
        }
    }
}
