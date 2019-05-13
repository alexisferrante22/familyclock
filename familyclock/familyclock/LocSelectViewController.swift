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

class LocSelectViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var selectLabel: UILabel!
    
    var locations = ["home", "work", "school", "dentist", "gym"]
    //coordinates stored in the coordinates variable will be in the order of: home, work, school, dentist, gym
    var coordinates = [CLLocationCoordinate2D(),CLLocationCoordinate2D(),CLLocationCoordinate2D(),CLLocationCoordinate2D(),CLLocationCoordinate2D()]
    
    var userLocationData = [("",(CLLocationDegrees(0.0), CLLocationDegrees(0.0))), ("",(CLLocationDegrees(0.0), CLLocationDegrees(0.0))), ("",(CLLocationDegrees(0.0), CLLocationDegrees(0.0))), ("",(CLLocationDegrees(0.0), CLLocationDegrees(0.0))), ("",(CLLocationDegrees(0.0), CLLocationDegrees(0.0)))]
    
    let userPin = MKPointAnnotation()
    var locationManager = CLLocationManager()
    var userManager = UserManager()
    var index = 0
    var annotations = [MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation(),MKPointAnnotation()]
    
    
    @IBAction func tapGesture(_ sender: Any) {
        //print("index, ", index)
        //print(userLocationData)
        if ((sender as AnyObject).state == .ended) {
            if (index < locations.count) {
                let locationInView = (sender as AnyObject).location(in: mapView)
                let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
                coordinates[index] = tappedCoordinate
                userLocationData[index] = ((locations[index], (tappedCoordinate.longitude, tappedCoordinate.latitude)))
                
                dropPin(name: locations[index], place: tappedCoordinate)
                index += 1
                //print(userLocationData)
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
    
    
    @IBAction func doneButton(_ sender: Any) {
        userLocationData.insert(("current", (locationManager.location?.coordinate.longitude ?? 0.0, locationManager.location?.coordinate.latitude ?? 0.0)), at: 0)
        //print(userLocationData)
        
        userManager.initializeIfNewUser(locationData: userLocationData){ isNewUser in
            //print("initialized user")
            //connect to next page
            self.performSegue(withIdentifier: "LocSelectToTabViewSegue", sender: self)
        }
    }
    
        
    
    @IBAction func prevButton(_ sender: Any) {
        if (index > 0) {
            index -= 1
            mapView.removeAnnotation(annotations[index])
            print(annotations[index])
            location.text = locations[index]
            if (done.isHidden == false) {
                done.isHidden = true
                selectLabel.text = "Select Location:"
                location.isHidden = false
            }
        }
    }
    
    func dropPin(name: String, place: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = place
        pin.title = name
        annotations[index] = pin
        mapView.addAnnotation(pin)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.userLocationData = self.userLocationData
        }
    }
    
    func checkAuth() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth()
        locationManager.delegate = self
        //self.mapView.addSubview(location)
        //self.mapView.addSubview(instructionLabel)
        //self.mapView.bringSubviewToFront(location)
        //self.mapView.bringSubviewToFront(instructionLabel)
        location.text = locations[0]
        done.isHidden = true
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    



}
