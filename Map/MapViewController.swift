//
//  MapViewController.swift
//  Map
//
//  Created by 小島徹也 on 2019/04/28.
//  Copyright © 2019 kotalab.com. All rights reserved.
//

import UIKit
import GoogleMaps

final class MapViewController: UIViewController {
    init(location: CLLocationCoordinate2D) {
        self.location = location
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let location: CLLocationCoordinate2D

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withTarget: location, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
    }
}
