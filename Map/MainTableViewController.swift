//
//  MainTableViewController.swift
//  Map
//
//  Created by 小島徹也 on 2019/05/05.
//  Copyright © 2019 kotalab.com. All rights reserved.
//

import UIKit
import CoreLocation

final class MainTableViewController: UITableViewController {

    @IBOutlet private weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        statusLabel.text = LocationManager.shared.authorizationStatus
        LocationManager.shared.didChangeAuthorization = { [weak self] status in
            self?.statusLabel.text = status
        }
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            LocationManager.shared.requestAuthorization()
            tableView.deselectRow(at: indexPath, animated: true)
        }

        if
            indexPath.section == 1 &&
                indexPath.row == 0 &&
                LocationManager.shared.canUseLocation
        {
            let currentLocation = LocationManager.shared.currentLocation()
            let mapViewController = MapViewController(settings: MapSettings(cameraLocation: currentLocation.coordinate, showsUserLocation: true, pins: []))
            navigationController?.pushViewController(mapViewController, animated: true)
        }

        if indexPath.section == 1 && indexPath.row == 1 {
            let tokyo = CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125)
            let yurakucho = CLLocationCoordinate2D(latitude: 35.674919, longitude: 139.76282)
            let pins = [
                Pin(coordinate: tokyo, title: "東京駅", subtitle: nil),
                Pin(coordinate: yurakucho, title: "有楽町駅", subtitle: "山手線"),
            ]
            let mapVC = MapViewController(settings: MapSettings(cameraLocation: tokyo, showsUserLocation: false, pins: pins))
            navigationController?.pushViewController(mapVC, animated: true)
        }
    }
}
