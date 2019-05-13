//
//  MagicMapController.swift
//  familyclock
//
//  Created by Brad Lee on 5/6/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class MagicMapController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var people : [String:CLLocationCoordinate2D] = [:]
        userManager.getFriendsLocations { userNumber, fu in
            for friendUser in fu {
                people[friendUser.email] = CLLocationCoordinate2D(latitude: friendUser.currentLocation.1, longitude: friendUser.currentLocation.0)
                //print("map friends locations",friendUser.email, friendUser.currentLocation)
            }
            //add current user to map also
            people[(self.userManager.user?.email)!] = self.locationManager.location?.coordinate
            //print("people", people)
            self.addAnnotations(people: people)
            //print("annotations:", self.mapView.annotations.count)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
//        people[(self.userManager.user?.email)!] = self.locationManager.location?.coordinate
//        print("people", people)
//        self.addAnnotations(people: people)
//        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var people : [String:CLLocationCoordinate2D] = [:]
        userManager.getFriendsLocations { userNumber, fu in
            for friendUser in fu {
                people[friendUser.email] = CLLocationCoordinate2D(latitude: friendUser.currentLocation.1, longitude: friendUser.currentLocation.0)
                //print("map friends locations",friendUser.email, friendUser.currentLocation)
            }
            //add current user to map also
            people[(self.userManager.user?.email)!] = self.locationManager.location?.coordinate
            //print("people", people)
            self.addAnnotations(people: people)
            //print("annotations:", self.mapView.annotations.count)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    }
    
    func addAnnotations(people: [String: CLLocationCoordinate2D]) {
        var annotationList: [MKPointAnnotation] = []
        for elem in people {
            let annotation = MKPointAnnotation()
            annotation.title = elem.key
            annotation.coordinate = elem.value
            annotationList.append(annotation)
        }
        mapView.addAnnotations(annotationList)
    }
}
