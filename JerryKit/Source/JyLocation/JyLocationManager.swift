//
//  JyLocationManager.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import CoreLocation

public class JyLocationManager:NSObject {
    
    var _locationManager:CLLocationManager?

    func start(){
        _locationManager = CLLocationManager()
        guard let locationManager = _locationManager else {
            return dprint("locationManager fail")
        }
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    func pause(){
        guard let locationManager = _locationManager else {
            return dprint("locationManager fail")
        }
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingLocation()
    }
    func getCurrentLocation() -> CLLocation? {
        guard let locationManager = _locationManager else {
            dprint("locationManager fail")
            return nil
        }
        let point = locationManager.location
        return point
    }
    func getCurrentCoordinate() -> CLLocationCoordinate2D? {
        guard let locationManager = _locationManager else {
            dprint("locationManager fail")
            return nil
        }
        let point = locationManager.location?.coordinate
        return point
    }
    func getCurrentAltitude() ->  CLLocationDistance? {
        guard let locationManager = _locationManager else {
            dprint("locationManager fail")
            return nil
        }
        let point = locationManager.location?.altitude
        return point
    }
}
extension JyLocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            dprint("didUpdateLocations=", location)
        }
    }
}
