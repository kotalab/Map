//
//  MapViewController.swift
//  Map
//
//  Created by 小島徹也 on 2019/04/28.
//  Copyright © 2019 kotalab.com. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

final class MapViewController: UIViewController {
    init(location: CLLocation) {
        self.location = location
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let location: CLLocation

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView

        let mapKit = MKMapView(frame: CGRect.zero)

        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapKit.setRegion(region, animated: false)
        mapKit.userTrackingMode = .followWithHeading
        view = mapKit
    }
}
