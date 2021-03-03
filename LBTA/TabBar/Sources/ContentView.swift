import SwiftUI

/// The main entrance to the application
struct RootView: View {
    /// Indicates the tab bar button being currently pressed.
    @State var selectedIndex = 0
    /// Boolean indicating whether the target modal view should be displayed or not.
    @State var shouldShowModal = false
    /// The SF icons names for the tabbar icons.
    let iconNames = ["person", "gear", "plus.app.fill", "pencil", "lasso"]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Spacer().fullScreenCover(isPresented: self.$shouldShowModal, content: {
                    Button { self.shouldShowModal.toggle() }
                    label: { Text("Fullscreen cover") }
                })
                
                switch self.selectedIndex {
                case 0:
                    NavigationView {
                        Text("First").navigationTitle("First Tab")
                    }
                case 1:
                    ScrollView {
                        Text("TEST")
                    }
                default:
                    NavigationView {
                        Text("Remaining tabs")
                    }
                }
            }
            
            Divider()
            
            HStack {
                ForEach(0..<self.iconNames.count) { num in
                    Button(action: {
                        self.selectedIndex = num
                        if num == 2 { self.shouldShowModal.toggle() }
                    }, label: {
                        Spacer()
                        if num == 2 {
                            Image(systemName: self.iconNames[num])
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: self.iconNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(self.selectedIndex == num ? Color(.black) : Color(white: 0.8))
                        }
                        Spacer()
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
