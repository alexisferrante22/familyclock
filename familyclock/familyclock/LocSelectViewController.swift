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
    
    var locations = ["home", "work", "school", "dentist", "gym", "done!"]
    //coordinates stored in the coordinates variable will be in the order of: home, work, school, dentist, gym
    var coordinates: [CLLocationCoordinate2D] = []
    let mapRadius: CLLocationDistance = 7000000
    var userLocationData : [(String,(CLLocationDegrees, CLLocationDegrees))] = []
    let newPin = MKPointAnnotation()
    var locationManager = CLLocationManager()
    
    @IBAction func tapGesture(_ sender: Any) {
        if ((sender as AnyObject).state == .ended) {
            let locationInView = (sender as AnyObject).location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            if (coordinates.count < 5) {
                coordinates.append(tappedCoordinate)
                userLocationData.append((locations[userLocationData.count], (tappedCoordinate.longitude, tappedCoordinate.latitude)))
                print(userLocationData)
                location.text = locations[coordinates.count]
            }
            print(coordinates)
            print("")
            dropPin(name: locations[coordinates.count-1], place: tappedCoordinate)
            if (coordinates.count >= 5) {
                print("continue")
                //connect to next page here
                self.performSegue(withIdentifier: "LocSelectToTabViewSegue", sender: self)
            }
        }
    }
    
    func dropPin(name: String, place: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = place
        pin.title = name
        mapView.addAnnotation(pin)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.userLocationData = self.userLocationData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        location.text = locations[0]
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations points: [CLLocation]) {
        mapView.removeAnnotation(newPin)
        let point = points.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
        let area = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(area, animated: true)
        newPin.coordinate = point.coordinate
        newPin.title = "You"
        mapView.addAnnotation(newPin)
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

