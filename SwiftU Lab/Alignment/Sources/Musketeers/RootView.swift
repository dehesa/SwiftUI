// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/alignment-guides
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

struct RootView: View {
    @State private var alignment: HorizontalAlignment = .leading
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: self.alignment) {
                LabelView(title: "Athos", color: .green)
                    .alignmentGuide(.leading, computeValue: { _ in 30 } )
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 30 } )
                    .alignmentGuide(.trailing, computeValue: { _ in 90 } )
                
                LabelView(title: "Porthos", color: .red)
                    .alignmentGuide(.leading, computeValue: { _ in 90 } )
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 30 } )
                    .alignmentGuide(.trailing, computeValue: { _ in 30 } )
                
                LabelView(title: "Aramis", color: .blue) // use implicit guide
            }
            Spacer()
            HStack {
                Button("leading")  { withAnimation(.easeInOut(duration: 2)) { self.alignment = .leading }}
                Button("center")   { withAnimation(.easeInOut(duration: 2)) { self.alignment = .center }}
                Button("trailing") { withAnimation(.easeInOut(duration: 2)) { self.alignment = .trailing }}
            }
        }
    }
}

// MARK: -

private extension RootView {
    struct LabelView: View {
        let title: String
        let color: Color
        
        var body: some View {
            Text(title)
                .font(.title)
                .padding(10)
                .frame(width: 200, height: 40)
                .background(RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(gradient: Gradient(colors: [color, .black]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 2, y: 1))))
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
