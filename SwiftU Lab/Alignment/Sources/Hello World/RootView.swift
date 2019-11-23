// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/alignment-guides
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

struct RootView: View {
    @State private var mode: Mode = .horizontal(.default)
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                // This is the green "Hello " rounded rectangle
                Group {
                    Text("Hello").foregroundColor(.black) + Text(" World").foregroundColor(.clear)
                }.padding(20)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.green).opacity(0.5))
                .alignmentGuide(HorizontalAlignment.center) { (dimensions) in
                    guard case .horizontal(.reverse) = self.mode else { return 0 }
                    return dimensions[.leading] - 10
                }.alignmentGuide(VerticalAlignment.center) { (dimensions) in
                    guard case .vertical(let readability) = self.mode else { return 0 }
                    switch readability {
                    case .default: return dimensions[.bottom] + 10
                    case .reverse: return dimensions[.top] - 10
                    }
                }
                
                // This is the yellow " World" rounded rectangle
                Group {
                    Text("Hello").foregroundColor(.clear) + Text(" World").foregroundColor(.black)
                }.padding(20)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow).opacity(0.5))
                .alignmentGuide(HorizontalAlignment.center) { (dimensions) in
                    guard case .horizontal(.reverse) = self.mode else { return 0 }
                    return dimensions[.trailing] + 10
                }
                .alignmentGuide(VerticalAlignment.center) { (dimensions) in
                    guard case .vertical(let readability) = self.mode else { return 0 }
                    switch readability {
                    case .default: return dimensions[.top] - 10
                    case .reverse: return dimensions[.bottom] + 10
                    }
                }
            }
            Spacer()
            HStack {
                Button(action: { withAnimation(.easeInOut(duration: 1.0)) { self.mode = .horizontal(.default) } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("H W").foregroundColor(.black))
                })
                Button(action: { withAnimation(.easeInOut(duration: 1.0)) { self.mode = .vertical(.default) } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("H\nW").foregroundColor(.black))
                })
                Button(action: { withAnimation(.easeInOut(duration: 1.0)) { self.mode = .horizontal(.reverse) } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("W H").foregroundColor(.black))
                })
                Button(action: { withAnimation(.easeInOut(duration: 1.0)) { self.mode = .vertical(.reverse) } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("W\nH").foregroundColor(.black))
                })
            }
        }
    }
}

// MARK: -

private extension RootView {
    enum Mode {
        case horizontal(Readability)
        case vertical(Readability)
        
        enum Readability {
            case `default`
            case reverse
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
