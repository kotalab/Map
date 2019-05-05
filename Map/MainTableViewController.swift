//
//  MainTableViewController.swift
//  Map
//
//  Created by 小島徹也 on 2019/05/05.
//  Copyright © 2019 kotalab.com. All rights reserved.
//

import UIKit

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
            let mapViewController = MapViewController(settings: MapSettings(cameraLocation: currentLocation.coordinate, showsUserLocation: true))
            navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
}
