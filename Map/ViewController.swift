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
    }

    @IBAction func didTapOpenMapButton(_ sender: Any) {
        let location = MapViewController.Location(latitude: -33.86, longitude: 151.20)
        let mapViewController = MapViewController(location: location)
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}

