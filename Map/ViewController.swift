//
//  ViewController.swift
//  Map
//
//  Created by 小島徹也 on 2019/04/26.
//  Copyright © 2019 kotalab.com. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        LocationManager.shared.requestAuthorization()
    }

    @IBAction func didTapOpenMapButton(_ sender: Any) {
        if LocationManager.shared.canUseLocation {
            let currentLocation = LocationManager.shared.currentLocation()
            let mapViewController = MapViewController(location: currentLocation.coordinate)
            navigationController?.pushViewController(mapViewController, animated: true)
        } else {

        }
    }
}

