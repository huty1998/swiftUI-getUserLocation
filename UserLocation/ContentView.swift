import SwiftUI
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var lastLocation: CLLocation?
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last
    }
}

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        Map(){
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
        }
        VStack {
            if let location = locationManager.lastLocation {
                Text("Your location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            }
        }
    }
}

#Preview {
    ContentView()
}
