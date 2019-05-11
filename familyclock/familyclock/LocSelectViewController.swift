//
//  LocSelectViewController.swift
//  familyclock
//
//  Created by Brad Lee on 4/30/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocSelectViewController: UIViewController, CLLocationManagerDelegate  {

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var done: UIButton!
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            if (index < locations.count) {
                let tappedCoordinate = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
                coordinates[index] = tappedCoordinate
                dropPin(name: locations[index], place: tappedCoordinate)
                index += 1
                if (index > locations.count-1) {
                    done.isHidden = false
                    location.isHidden = true
                    selectLabel.text = "Tap 'next' to proceed"
                } else {
                    location.text = locations[index]
                }
            }
        }
    }
    
    @IBAction func prevButton(_ sender: Any) {
        if (index > 0) {
            index -= 1
            mapView.removeAnnotation(annotations[index])
            location.text = locations[index]
            if (done.isHidden == false) {
                done.isHidden = true
                selectLabel.text = "Select Location:"
                location.isHidden = false
            }
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        //segue here!
    }
    
    var index = 0
    //coordinates stored in the coordinates variable will be in the order of: home, work, school, dentist, gym
    var locations = ["Home", "Work", "School", "Dentist", "Gym"]
    var coordinates = [CLLocationCoordinate2D(),CLLocationCoordinate2D(),CLLocationCoordinate2D(),CLLocationCoordinate2D(),CLLocationCoordinate2D()]
    var annotations = [MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation()]
    var locationManager = CLLocationManager()
    let userPin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        done.isHidden = true
        checkAuth()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations points: [CLLocation]) {
        mapView.removeAnnotation(userPin)
        let point = points.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
        let area = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(area, animated: true)
        userPin.coordinate = point.coordinate
        userPin.title = "You"
        mapView.addAnnotation(userPin)
    }
    
    func checkAuth() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func dropPin(name: String, place: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = place
        pin.title = name
        annotations[index] = pin
        mapView.addAnnotation(pin)
    }
}
