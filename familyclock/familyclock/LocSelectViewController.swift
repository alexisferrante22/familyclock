//
//  LocSelectViewController.swift
//  familyclock
//
//  Created by Brad Lee on 4/30/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import UIKit
import MapKit

class LocSelectViewController: UIViewController {
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locations = ["home", "work", "school", "dentist", "gym", "done"]
    //coordinates stored in the coordinates variable will be in the order of: home, work, school, dentist, gym
    var coordinates: [CLLocationCoordinate2D] = []
    let mapRadius: CLLocationDistance = 7000000
    var userLocationData : [(String,(CLLocationDegrees, CLLocationDegrees))] = []
    
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
            if (coordinates.count >= 5) {
                print("continue")
                //connect to next page here
                self.performSegue(withIdentifier: "LocationSelectToClockSegue", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? ViewController
        {
            vc.userLocationData = self.userLocationData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initLocation = CLLocation(latitude: 37.0902, longitude: -95.7129)
        centerMap(location: initLocation)
        location.text = locations[0]
    }
    
    func centerMap(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: mapRadius, longitudinalMeters: mapRadius)
        mapView.setRegion(coordinateRegion, animated: true)
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

