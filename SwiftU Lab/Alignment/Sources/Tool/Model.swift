// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/alignment-guides
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

final class Model: ObservableObject {
    @Published var minimumContainer = true
    @Published var extendedTouchBar = false
    @Published var twoPhases = true
    @Published var addImplicitView = false
    @Published var showImplicit = false
    
    @Published var algn: [AlignmentEnum] = [.center, .center, .center]
    @Published var delayedAlgn: [AlignmentEnum] = [.center, .center, .center]
    @Published var frameAlignment: Alignment = .center
    @Published var stackAlignment: HorizontalAlignment = .leading
    
    func nextAlignment() -> Alignment {
        if self.frameAlignment == .leading {
            return .center
        } else if self.frameAlignment == .center {
            return .trailing
        } else {
            return .leading
        }
    }
}

enum AlignmentEnum: Equatable {
    case leading
    case center
    case trailing
    case value(CGFloat)
    
    var asString: String {
        switch self {
        case .leading:  return "d[.leading]"
        case .center:   return "d[.center]"
        case .trailing: return "d[.trailing]"
        case .value(let v): return "\(v)"
        }
    }
    
    func asNumber(width: CGFloat) -> CGFloat {
        switch self {
        case .leading:  return 0
        case .center:   return width / 2.0
        case .trailing: return width
        case .value(let v): return v
        }
    }
    
    func computedValue(_ d: ViewDimensions) -> CGFloat {
        switch self {
        case .leading:  return d[.leading]
        case .center:   return d.width / 2.0
        case .trailing: return d[.trailing]
        case .value(let v): return v
        }
    }
    
    static func fromHorizontalAlignment(_ a: HorizontalAlignment) -> AlignmentEnum {
        switch a {
        case .leading:  return .leading
        case .center:   return .center
        case .trailing: return .trailing
        default: return .value(0)
        }
    }
}

