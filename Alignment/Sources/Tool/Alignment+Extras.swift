import SwiftUI

extension Alignment {
    var asString: String {
        switch self {
        case .leading:  return ".leading"
        case .center:   return ".center"
        case .trailing: return ".trailing"
        default:        return "unknown"
        }
    }
}

extension Alignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .leading:  hasher.combine(0)
        case .center:   hasher.combine(1)
        case .trailing: hasher.combine(2)
        default:        hasher.combine(3)
        }
    }
}

extension HorizontalAlignment {
    var asString: String {
        switch self {
        case .leading:  return ".leading"
        case .trailing: return ".trailing"
        case .center:   return ".center"
        default:        return "unknown"
        }
    }
}

extension HorizontalAlignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .leading:  hasher.combine(0)
        case .center:   hasher.combine(1)
        case .trailing: hasher.combine(2)
        default:        hasher.combine(3)
        }
    }
}
