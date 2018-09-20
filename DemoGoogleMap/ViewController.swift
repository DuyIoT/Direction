//
//  ViewController.swift
//  DemoGoogleMap
//
//  Created by admin on 9/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    let direction = DirectionService()
    override func viewDidLoad() {
        super.viewDidLoad()
        determineMyCurrentLocation()
        initMapView()
        getDirection()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getDirection() {
        direction.getDirection("Disneyland", "Universal+Studios+Hollywood", "AIzaSyCMnoMIKYIFK7mj_SEP9aHomGENNtGrbGk") { (success) in
            if success {
                self.drawRoute()
            }
        }
    }
    func determineMyCurrentLocation() {
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    func initMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 21.016950, longitude: 105.783746, zoom: 5.0)
        mapView.camera = camera
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        let marker = GMSMarker()
        marker.title = "KeangNam Landmark"
        marker.snippet = "Hà Nội"
        marker.position = CLLocationCoordinate2DMake(21.016950, 105.783746)
        marker.map = mapView
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locationUser = locations.first {
            print(locationUser.coordinate)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let arlert = UIAlertController(title: "Lỗi", message: "Chưa cài đặt location", preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "Đồng ý", style: .default, handler: nil)
        arlert.addAction(btnOK)
        self.present(arlert, animated: true, completion: nil)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    fileprivate func drawRoute() {
        for step in self.direction.selectSteps {
            if step.polyline.points != "" {
                let path = GMSPath(fromEncodedPath: step.polyline.points)
                let routePolyline = GMSPolyline(path: path)
                routePolyline.strokeColor = UIColor.red
                routePolyline.strokeWidth = 3.0
                routePolyline.map = mapView
            } else {
                return
            }
        }
    }
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

