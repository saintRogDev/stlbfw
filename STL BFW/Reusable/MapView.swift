//
//  MapView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/23/23.
//

import Contacts
import SwiftUI
import MapKit

class Pin: NSObject, ObservableObject, Identifiable, MKAnnotation {
    @Published var coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: CLLocationDegrees(38.632700),
                                       longitude: CLLocationDegrees(-90.199770)), // Default coordinates (San Francisco)
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )

    @State var address: String
    let name: String?
    let postalAddress: CNPostalAddress
    @State private var pin: Pin?

    init(address: String,
         name: String? = nil,
         pin: Pin? = nil) {
        self.address = address
        self.name = name
        self.pin = pin
        let addressComponents = address
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        let postal = CNMutablePostalAddress()
        if addressComponents.count >= 4 {
            postal.street = addressComponents[0]
            postal.city = addressComponents[1]
            postal.state = addressComponents[2]
            postal.postalCode = addressComponents[3]
        } else {
            print("Invalid address format")
        }
        postalAddress = postal
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let pin = self.pin {
                Map(coordinateRegion: $region,
                    annotationItems: [pin].compactMap { $0 }) { pin in
                    MapPin(coordinate: pin.coordinate, tint: .black)
                
                }
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                VStack(alignment: .leading, spacing: 0) {
                    name.map {
                        Text($0)
                            .font(.caption)
                    }
                    Text(address)
                        .font(.caption)
                }
                .padding(.leading, 5)
            }
        }
        .padding(.vertical, 10)
        .onAppear {
            geocodeAddress()
        }
        .onTapGesture {
            if let pin = pin {
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: pin.coordinate,
                                                               postalAddress: postalAddress ))
                mapItem.openInMaps()
            }
        }
    }

    private func geocodeAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemark = placemarks?.first,
               let location = placemark.location {
                let pin = Pin(coordinate: location.coordinate)
                self.pin = pin
                self.region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                   longitude: location.coordinate.longitude), // Default coordinates (San Francisco)
                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                )
                self.region.center = location.coordinate
            } else {
                print("Unable to geocode address")
            }
        }
    }
    
    static func canGeocodeAddress(address: String) -> Bool  {
        let geocoder = CLGeocoder()
        var geocodable = false
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemark = placemarks?.first,
               let _ = placemark.location {
                geocodable =  true
            } else {
                geocodable = false
            }
        }
        return geocodable
    }
}
