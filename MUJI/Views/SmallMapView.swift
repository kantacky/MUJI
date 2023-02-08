import SwiftUI
import MapKit

struct SmallMapView: View {
    @State var stores: [Store]
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        ),
        latitudinalMeters: 1000.0,
        longitudinalMeters: 1000.0
    )
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: stores, annotationContent: { place in
            MapMarker(coordinate: place.coordinate, tint: Color.red)
        })
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    region.center = stores[0].coordinate
                }
            }
    }
}

struct SmallMapView_Previews: PreviewProvider {
    static var previews: some View {
        SmallMapView(stores: [Store.sampleData[0]])
            .environmentObject(MUJIViewModel())
    }
}
