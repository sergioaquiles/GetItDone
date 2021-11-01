//
//  LocationManager.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 04/10/21.
//

import SwiftUI
import MapKit


class MapViewModel:  NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion()
    
    @Published var address = ""
    @Published var latitude = 0.0
    @Published var longitude = 0.0
    @Published var alertItem: AlertItem?
    @Published var searchText = ""
    @Published var places: [Place] = []
    
    override init() {
        super .init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        isLocationEnable()
    }
    
    func isLocationEnable() {
        
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            alertItem = AlertContext.locationOff
            print("Your location is off, turn it on!")
        }
    }
    
    func searchLocation() {
        
        places.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        MKLocalSearch(request: request).start { (response, _) in
            guard let result = response else {return}
            
            self.places = result.mapItems.compactMap({ item -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    
    func selectPlace(place: Place) {
        searchText = ""
        UIApplication.shared.endEditing()
        guard let coordinate  = place.place.location?.coordinate else {return}
        getHumanReadableAddress(place.place.location!)
        print("SELECTED \(address)")
        
        places.append(place)
        print("Annotations on the MAP \(places.count)")
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
    }
    
    
    private func checkLocationAuthorization() {
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.restricted
            print("Your location is restricted")
        case .denied:
            alertItem = AlertContext.denied
            print("You denied your location")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.last else { return }
        
        self.region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
        
        getHumanReadableAddress(userLocation)
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    
    func getHumanReadableAddress(_ location: CLLocation) {
        
              
        CLGeocoder().reverseGeocodeLocation(location) { details, error in
            
            
            if error == nil {
                
                if let localData = details?.last {
                    
                    var city = ""
                    if localData.locality != nil {
                        city = localData.locality!
                    }
                    var street = ""
                    if localData.thoroughfare != nil {
                        street = localData.thoroughfare!
                    }
                    var state = ""
                    if localData.administrativeArea != nil {
                        state = localData.administrativeArea!
                    }
                    var zipCode = ""
                    if localData.postalCode != nil {
                        zipCode = localData.postalCode!
                    }
                    var district = ""
                    if localData.subLocality != nil {
                        district = localData.subLocality!
                    }
                    var number = ""
                    if localData.subThoroughfare != nil {
                        number = localData.subThoroughfare!
                    }
                    
                    self.address = street + ", " + number + ", " + district + "- " + city + "/ " + state + " CEP: " + zipCode
                    
                }
            }
        }
    }
    
}


struct AddressPreferenceKey: PreferenceKey {
        
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
