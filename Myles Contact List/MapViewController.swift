//
//  SecondViewController.swift
//  Myles Contact List
//
//  Created by Myles Young on 11/2/19.
//  Copyright © 2019 Myles Young. All rights reserved.
//
import MapKit
import UIKit
import CoreLocation
class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()

        locationManager.delegate = self as? CLLocationManagerDelegate
        mapView.delegate = self as? MKMapViewDelegate
        locationManager.requestWhenInUseAuthorization()    }

  //   override func viewWillAppear(_ animated: Bool) {
        //mapView.setUserTrackingMode(.follow, animated: true)


        

//}

    @IBAction func findUser(_ sender: Any) {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
}
