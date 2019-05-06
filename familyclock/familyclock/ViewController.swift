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
    
    let locationManager = CLLocationManager()
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser
    var userManager = UserManager()
    var userLocationData : [(String, (CLLocationDegrees, CLLocationDegrees))] = []
    

    //map stuff
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

        let myLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)

        let region : MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //map stuff
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        /* Below are some examples of how to use userManager functions.
         Firebase functions are asynchronous which is why when you use them you
         have to write code within the {} following the function, otherwise there
         is no guarantee that the data has been fetched at the time
         you are trying to access it. Essentially, I'm passing a value from the
         function into the completion block {} for you to use here. Feel free
         to delete these function calls, they are only examples to display
         functionality. */
        
        let deg = CLLocationDegrees(80.0)
        let deg2 = CLLocationDegrees(20.0)
        let locationData = [("current", (deg2, deg2)), ("home", (deg, deg)), ("work", (deg, deg)), ("gym", (deg, deg)), ("school", (deg, deg)), ("dentist", (deg2, deg2))]
        
        userManager.initializeIfNewUser(locationData: userLocationData) { (exists) in
            print("current user is a new user? ", exists)
        }

//        userManager.addFriend(friendEmail: "alexisf4567@gmail.com"){
//            print("adding friend")
//        }

        userManager.getFriendsEmails {emailAddresses in
            print(emailAddresses)
        }

        userManager.getNumberOfFriends{numFriends in
            print("num friends: \(numFriends)")
        }
        
        userManager.getLocationTypeCoordsForUser(userDocumentReference: db.collection("users").document((userManager.user?.uid)!), locationType: "home"){ (homeLong, homeLat) in
            print("fetching home coords", homeLong, homeLat)
            }
        userManager.getFriendsLocations {
            print("getting friends locations")
            if(self.userManager.friendUsers.count > 0){
                print(self.userManager.friendUsers[0].getLocation())
            }
        }
        
        print("userlocationdata: ", self.userLocationData)
    }
}

