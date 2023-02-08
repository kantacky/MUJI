import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 3.0
        manager.startUpdatingLocation()
        
        if let location = manager.location {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D (
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                ),
                latitudinalMeters: 10000.0,
                longitudinalMeters: 10000.0
            )
        }
    }
    
    func reloadRegion() {
        if let location = manager.location {
            region.center = CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        }
    }
}
