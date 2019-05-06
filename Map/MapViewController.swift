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

struct MapSettings {
    let cameraLocation: CLLocationCoordinate2D
    let showsUserLocation: Bool
    let pins: [Pin]
}

struct Pin {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
}
final class MapViewController: UIViewController {
    init(settings: MapSettings) {
        self.settings = settings
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let settings: MapSettings
    @IBOutlet private weak var googleMapView: GMSMapView!
    @IBOutlet private weak var mapKitView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSegmentedControl()
        setupAppleMap()
        setupGoogleMap()
    }

    private func setupSegmentedControl() {
        let segmentItems = ["Apple", "Google"]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }

    @objc func didChangeSegment(sender: UISegmentedControl) {
        self.googleMapView.isHidden = sender.selectedSegmentIndex == 0
        self.mapKitView.isHidden = sender.selectedSegmentIndex != 0
    }

    private func setupAppleMap() {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: settings.cameraLocation, span: span)
        mapKitView.setRegion(region, animated: false)
        mapKitView.userTrackingMode = settings.showsUserLocation ? .follow : .none

        settings.pins.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = $0.coordinate
            annotation.title = $0.title
            annotation.subtitle = $0.subtitle
            mapKitView.addAnnotation(annotation)
        }
    }

    private func setupGoogleMap() {
        let camera = GMSCameraPosition.camera(withTarget: settings.cameraLocation, zoom: 14.0)
        googleMapView.camera = camera
        googleMapView.isMyLocationEnabled = settings.showsUserLocation

        settings.pins.forEach {
            let marker = GMSMarker(position: $0.coordinate)
            marker.title = $0.title
            marker.map = googleMapView
        }

        googleMapView.isHidden = true
    }
}
