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
    @IBOutlet private weak var googleMapView: GMSMapView!
    @IBOutlet private weak var mapKitView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentItems = ["Apple", "Google"]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        navigationItem.titleView = segmentedControl

        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 16.0)
        googleMapView.camera = camera
        googleMapView.isMyLocationEnabled = true

        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapKitView.setRegion(region, animated: false)
        mapKitView.userTrackingMode = .follow

        googleMapView.isHidden = true
    }

    @objc func didChangeSegment(sender: UISegmentedControl) {
        self.googleMapView.isHidden = sender.selectedSegmentIndex == 0
        self.mapKitView.isHidden = sender.selectedSegmentIndex != 0
    }
}
