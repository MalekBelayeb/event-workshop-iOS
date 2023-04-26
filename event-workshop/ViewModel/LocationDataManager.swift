//
//  LocationDataManager.swift
//  event-workshop
//
//  Created by ODC on 26/4/2023.
//

import Foundation
import CoreLocation
import SwiftUI


class LocationDataManager:NSObject,ObservableObject,CLLocationManagerDelegate
{
    
    var locationManager = CLLocationManager()
    
    @Published var lastUpdatedLocation:CLLocationCoordinate2D?
    @Published var authorizationRejected:Bool = false
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = CLLocationDistance(1000) //m

    }
    
    
    func requestLocationAuthorization()
    {
        
        if self.locationManager.authorizationStatus == .denied || self.locationManager.authorizationStatus == .restricted
        {
            
            self.authorizationRejected = true
           
        }else if self.locationManager.authorizationStatus == .notDetermined
        {

            
            self.locationManager.requestWhenInUseAuthorization()
            
        }
        
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if(manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse)
        {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let coordinate = locations.last?.coordinate else {return}
        
        self.lastUpdatedLocation = coordinate
        
        
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
