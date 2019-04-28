//
//  LocationManager.swift
//  Map
//
//  Created by 小島徹也 on 2019/04/28.
//  Copyright © 2019 kotalab.com. All rights reserved.
//

import CoreLocation

final class LocationManager {
    static let shared: LocationManager = LocationManager()
    private let clLocationManager: CLLocationManager

    private init () {
        clLocationManager = CLLocationManager()
    }

    func requestAuthorization() {
        clLocationManager.requestWhenInUseAuthorization()
    }

    var canUseLocation: Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }

    func currentLocation() -> CLLocation {
        return clLocationManager.location!
    }
}
