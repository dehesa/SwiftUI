// Example reworked from the great SwiftUI Lab.
// Full article: https://swiftui-lab.com/custom-styling
// Twitter: https://twitter.com/SwiftUILab
import SwiftUI

extension TripleToggleView {
    struct AnyStyle: TripleToggleStyle {
        private let _makeBody: (TripleToggleStyle.Configuration) -> AnyView
        
        init<ST:TripleToggleStyle>(_ style: ST) {
            self._makeBody = style.makeBodyTypeErased
        }
        
        func makeBody(configuration: TripleToggleStyle.Configuration) -> AnyView {
            return self._makeBody(configuration)
        }
    }
}

// MARK: -

struct DefaultTripleToggleStyle: TripleToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        DefaultTripleToggle(state: configuration.$state, label: configuration.label)
    }
}

private extension DefaultTripleToggleStyle {
    struct DefaultTripleToggle: View {
        let width: CGFloat = 50
        @Binding var state: TripleToggleView.State
        var label: Text
        
        var stateAlignment: Alignment {
            switch self.state {
            case .low: return .leading
            case .med: return .center
            case .high: return .trailing
            }
        }

        var stateColor: Color {
            switch self.state {
            case .low: return .green
            case .med: return .yellow
            case .high: return .red
            }
        }

        var body: some View {
            VStack(spacing: 10) {
                self.label
                                
                ZStack(alignment: self.stateAlignment) {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: self.width, height: self.width / 2)
                        .foregroundColor(self.stateColor)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: (self.width / 2) - 4, height: self.width / 2 - 6)
                        .padding(4)
                        .foregroundColor(.white)
                        .onTapGesture {
                            withAnimation {
                                switch self.state {
                                case .low: self.$state.wrappedValue = .med
                                case .med: self.$state.wrappedValue = .high
                                case .high: self.$state.wrappedValue = .low
                                }
                            }
                        }
                }
            }
        }
    }
}

// MARK: -

struct KnobTripleToggleStyle: TripleToggleStyle {
    let dotColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        KnobTripleToggle(dotColor: dotColor, state: configuration.$state, label: configuration.label)
    }
}

private extension KnobTripleToggleStyle {
    struct KnobTripleToggle: View {
        let dotColor: Color
        @Binding var state: TripleToggleView.State
        var label: Text
        
        var angle: Angle {
                switch self.state {
                case .low: return Angle(degrees: -30)
                case .med: return Angle(degrees: 0)
                case .high: return Angle(degrees: 30)
            }
        }

        var body: some View {
            let g = Gradient(colors: [.white, .gray, .white, .gray, .white, .gray, .white])
            let knobGradient = AngularGradient(gradient: g, center: .center)
            
            return VStack(spacing: 10) {
                self.label
                ZStack {
                    Circle()
                        .fill(knobGradient)
                    DotShape()
                        .fill(self.dotColor)
                        .rotationEffect(self.angle)
                }.frame(width: 150, height: 150)
                .onTapGesture {
                    withAnimation {
                        switch self.state {
                        case .low:  self.$state.wrappedValue = .med
                        case .med:  self.$state.wrappedValue = .high
                        case .high: self.$state.wrappedValue = .low
                        }
                    }
                }
            }
        }
    }
    
    private struct DotShape: Shape {
        func path(in rect: CGRect) -> Path {
            Path(ellipseIn: CGRect(x: rect.width / 2 - 8, y: 8, width: 16, height: 16))
        }
    }
}
