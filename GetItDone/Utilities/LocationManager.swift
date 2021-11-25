//
//  LocationManager.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 22/11/21.
//

import Foundation
import MapKit


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    var locationManager = CLLocationManager()
    
    @Published var latitude: CLLocationDegrees = 0.0
    @Published var longitude: CLLocationDegrees = 0.0
    @Published var location: String = ""
    @Published var alertItem: AlertItem?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        isLocationEnable()
    }
    
    func isLocationEnable() {
        
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        
        } else {
            alertItem = AlertContext.locationOff
            print("Impossible to check the weather conditions, turn on your location")
        }
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
            self.latitude = locationManager.location?.coordinate.latitude ?? 0
            self.longitude = locationManager.location?.coordinate.longitude ?? 0
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.last else {
            print("impossible to get the user location")
            return
        }
        
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
    
    private func getHumanReadableAddress(_ location: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(location) { details, error in
            
            if error == nil {
                
                if let localData = details?.last {
                    
                    var city = ""
                    if localData.locality != nil {
                        city = localData.locality!
                    }
                    
                    var district = ""
                    if localData.subLocality != nil {
                        district = localData.subLocality!
                    }
                    
                    self.location = district+", " + city
                }
            }
        }
    }
}


