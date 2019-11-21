import SwiftUI

extension RootView {
    struct MiniMapView: View {
        let proxy: GeometryProxy
        let preferences: [Preference.Element]
        
        var body: some View {
            guard let formContainerAnchor = preferences.first(where: { $0.kind == .formContainer })?.bounds,
                  let miniMapAreaAnchor = preferences.first(where: { $0.kind == .miniMapArea })?.bounds else { return AnyView(EmptyView()) }
            // Calcualte a multiplier factor to scale the views from the form, into the minimap.
            let factor = proxy[formContainerAnchor].size.width / (proxy[miniMapAreaAnchor].size.width - 10.0)
            // Determine the position of the form
            let containerPosition = CGPoint(x: proxy[formContainerAnchor].minX, y: proxy[formContainerAnchor].minY)
            // Determine the position of the mini map area
            let miniMapPosition = CGPoint(x: proxy[miniMapAreaAnchor].minX, y: proxy[miniMapAreaAnchor].minY)
            
            return AnyView(miniMapView(factor, containerPosition, miniMapPosition))
        }
        
        func miniMapView(_ factor: CGFloat, _ containerPosition: CGPoint, _ miniMapPosition: CGPoint) -> some View {
            ZStack(alignment: .topLeading) {
                // Create a small representation of each of the form's views.
                // Preferences are traversed in reverse order, otherwise the branch views would be covered by their ancestors
                ForEach(preferences.reversed()) { pref in
                    if pref.show() { // some type of views, we don't want to show
                        self.rectangleView(pref, factor, containerPosition, miniMapPosition)
                    }
                }
            }.padding(5)
        }
        
        func rectangleView(_ pref: Preference.Element, _ factor: CGFloat, _ containerPosition: CGPoint, _ miniMapPosition: CGPoint) -> some View {
            Rectangle()
                .fill(pref.getColor())
                .frame(width: self.proxy[pref.bounds].size.width / factor, height: self.proxy[pref.bounds].size.height / factor)
                .offset(x: (self.proxy[pref.bounds].minX - containerPosition.x) / factor + miniMapPosition.x,
                        y: (self.proxy[pref.bounds].minY - containerPosition.y) / factor + miniMapPosition.y)
        }
        
    }
}

//struct MiniMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MiniMapView()
//    }
//}
