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
    
    @IBAction func tapGesture(_ sender: Any) {
        if (sender.state == .ended) {
            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            if (coordinates.count < 5) {
                coordinates.append(tappedCoordinate)
                location.text = locations[coordinates.count]
            }
            print(coordinates)
            print("")
            if (coordinates.count >= 5) {
                print("continue")
                //connect to next page here
            }
        }
    }
    
    var locations = ["home", "work", "school", "dentist", "gym", "gym"]
    //coordinates stored in the coordinates variable will be in the order of: home, work, school, dentist, gym
    var coordinates: [CLLocationCoordinate2D] = []
    let mapRadius: CLLocationDistance = 7000000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initLocation = CLLocation(latitude: 37.0902, longitude: -95.7129)
        centerMap(location: initLocation)
    }
    
    func centerMap(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, mapRadius, mapRadius)
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
