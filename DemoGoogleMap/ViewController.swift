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
class ViewController: UIViewController {
    
    @IBAction func requestDirection(_ sender: UIButton) {
        let origin = originTextField.text?.description
        let destination = destinationTextField.text?.description
        getDirection(origin, destination)
    }
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    let direction = DirectionService()
    var originLatitude: Double = 0
    var originLongtitude: Double = 0
    var destinationLatitude: Double = 0
    var destinationLongtitude: Double = 0
    var travelMode = TravelModes.driving
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDelegate()
        initMapView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getDirection(_ origin: String?, _ destination: String?) {
        direction.getDirection(origin, destination, "AIzaSyBGftbNczf1_3Koz3DW1x0LtXiqUr_u8g4") { (success) in
            print("BBBBBBB")
            print(success)
            if success {
                self.drawRoute()
                print("AAAAAAAAAAAA")
                print(self.direction.direction?.geocodedWaypoints.count ?? 0)
                print(self.direction.direction?.status ?? "")
            }
        }
    }
//    func determineMyCurrentLocation() {
//        locationManager.requestAlwaysAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        }
//    }
    func registerDelegate() {
        originTextField.delegate = self
        destinationTextField.delegate = self
    }
    func initMapView() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
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
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location: CLLocation = locations.last {
            let locationLatitude = location.coordinate.latitude
            let locationLongtitude = location.coordinate.longitude
            self.originLatitude = locationLatitude
            self.originLongtitude = locationLongtitude
            let camera = GMSCameraPosition.camera(
                withLatitude: locationLatitude,
                longitude: locationLongtitude, zoom: 15.0)
            if mapView.isHidden {
                mapView.isHidden = false
                mapView.camera = camera
            } else {
                mapView.animate(to: camera)
            }
        }
    }

    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        self.destinationLatitude = coordinate.latitude
        self.destinationLongtitude = coordinate.longitude
        let marker = GMSMarker(position: coordinate)
        marker.map = self.mapView
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == originTextField {
            destinationTextField.becomeFirstResponder()
        } else if textField == destinationTextField {
            destinationTextField.resignFirstResponder()
        } else {
            
        }
        return true
    }
}

