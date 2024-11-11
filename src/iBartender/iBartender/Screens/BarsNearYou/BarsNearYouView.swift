import SwiftUI
import MapKit
import CoreLocation

// The SwiftUI View for "BarsNearYou"
struct BarsNearYouView: View {
    @StateObject private var viewModel = BarsNearYouViewModel()

    var body: some View {
        VStack {
            Text("BarsNearYou")
                .font(.largeTitle)
                .padding()

            if viewModel.bars.isEmpty {
                Text("Searching for nearby bars...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                List(viewModel.bars, id: \.self) { bar in
                    VStack(alignment: .leading) {
                        Text(bar.name)
                            .font(.headline)
                        if let address = bar.address {
                            Text(address)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.requestLocation()
        }
    }
}

// The ViewModel for managing location and search functionality
class BarsNearYouViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var bars: [Bar] = []

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        // Request location authorization
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        findBars(near: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error)")
    }

    private func findBars(near location: CLLocation) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Bars"
        request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response, error == nil else {
                print("Search error: \(String(describing: error))")
                return
            }

            self?.bars = response.mapItems.compactMap { item in
                let name = item.name ?? "Unknown"
                let address = item.placemark.title
                return Bar(name: name, address: address)
            }
        }
    }
}

// The Bar model used for holding bar details
struct Bar: Hashable {
    let name: String
    let address: String?
}

#Preview {
    BarsNearYouView()
}
