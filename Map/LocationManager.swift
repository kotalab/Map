//
//  LocationManager.swift
//  Map
//
//  Created by 小島徹也 on 2019/04/28.
//  Copyright © 2019 kotalab.com. All rights reserved.
//

import CoreLocation
import GoogleMaps

final class LocationManager: NSObject {
    static let shared: LocationManager = LocationManager()
    private let clLocationManager: CLLocationManager

    var didUpdateLocation: ((CLLocation) -> Void)?
    var didChangeAuthorization: ((String) -> Void)?

    private override init () {
        clLocationManager = CLLocationManager()
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.distanceFilter = 50
        clLocationManager.startUpdatingLocation()

        super.init()
        clLocationManager.delegate = self
    }

    func requestAuthorization() {
        clLocationManager.requestWhenInUseAuthorization()
    }

    var authorizationStatus: String {
        return CLLocationManager.authorizationStatus().string
    }

    var canUseLocation: Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }

    func currentLocation() -> CLLocation {
        return clLocationManager.location!
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        didChangeAuthorization?(status.string)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        didUpdateLocation?(location)
    }
}

private extension CLAuthorizationStatus {
    var string: String {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways: return "authorizedAlways"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .denied: return "denied"
        case .notDetermined: return "notDetermined"
        case .restricted: return "restricted"
        @unknown default:
            fatalError()
        }
    }

}
