//
//  ViewController.swift
//  familyclock
//
//  Created by Alexis Ferrante on 4/23/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import GoogleSignIn
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser
    var userManager = UserManager()
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

        let myLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)

        let region : MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        map.setRegion(region, animated: true)

        self.map.showsUserLocation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //map stuff
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        userManager.getFriendsEmails {emailAddresses in
//            print(emailAddresses)
//        }
        
        userManager.initializeIfNewUser { (exists) in
            print("user already in db? ", exists)
        }
        
        userManager.addFriend(friendEmail: "alexisf22@gmail.com"){
            print("hello")
        }
        
        userManager.getNumberOfFriends{numFriends in
            print("num friends: \(numFriends)")
        }
    }
}

