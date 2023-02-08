import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: MUJIViewModel
    @ObservedObject var manager = LocationManager()
    @State var trackingMode = MapUserTrackingMode.follow
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $manager.region, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: viewModel.stores, annotationContent: { place in
                MapMarker(coordinate: place.coordinate, tint: Color.red)
            })
            .edgesIgnoringSafeArea([.top, .horizontal])
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        manager.reloadRegion()
                    }) {
                        Image(systemName: "location.fill")
                            .padding(8)
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding()
                }
                Spacer()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchStore()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(MUJIViewModel())
    }
}
