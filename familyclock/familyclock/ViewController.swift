////
////  ViewController.swift
////  familyclock
////
////  Created by Alexis Ferrante on 4/23/19.
////  Copyright © 2019 Alexis Ferrante. All rights reserved.
////
//
//import UIKit
//import FirebaseDatabase
//import Firebase
//import FirebaseFirestore
//import GoogleSignIn
//import MapKit
//import CoreLocation
//
//class ViewController: UIViewController, CLLocationManagerDelegate {
//
//    let locationManager = CLLocationManager()
//    let db = Firestore.firestore()
//    let ref = Database.database().reference()
//    let user = Auth.auth().currentUser
//    var userManager = UserManager()
//    var userLocationData : [(String, (CLLocationDegrees, CLLocationDegrees))] = []
//
//
//    //map stuff
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//
//        let myLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//
//        let region : MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //map stuff
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//
//        /* Below are some examples of how to use userManager functions.
//         Firebase functions are asynchronous which is why when you use them you
//         have to write code within the {} following the function, otherwise there
//         is no guarantee that the data has been fetched at the time
//         you are trying to access it. Essentially, I'm passing a value from the
//         function into the completion block {} for you to use here. Feel free
//         to delete these function calls, they are only examples to display
//         functionality. */
//
//        let deg = CLLocationDegrees(80.0)
//        let deg2 = CLLocationDegrees(20.0)
////        let locationData = [("current", (deg2, deg2)), ("home", (deg, deg)), ("work", (deg, deg)), ("gym", (deg, deg)), ("school", (deg, deg)), ("dentist", (deg2, deg2))]
//
//        userManager.isNewUser{ exists in
//            if(!exists){
//                print("user didn't exist: transition to map select view")
//                self.performSegue(withIdentifier: "clockToLocationSelect", sender: self)
//            }
//        }
//        userManager.initializeIfNewUser(locationData: userLocationData) { (exists) in
//            print("current user is a new user? ", exists)
//        }
//
////        userManager.addFriend(friendEmail: "alexisf4567@gmail.com"){
////            print("adding friend")
////        }
//
//        userManager.getFriendsEmails {emailAddresses in
//            print(emailAddresses)
//        }
//
//        userManager.getNumberOfFriends{numFriends in
//            print("num friends: \(numFriends)")
//        }
//
//        userManager.getLocationTypeCoordsForUser(userDocumentReference: db.collection("users").document((userManager.user?.uid)!), locationType: "home"){ (homeLong, homeLat) in
//            print("fetching home coords", homeLong, homeLat)
//            }
//        userManager.getFriendsLocations {
//            print("getting friends locations")
//            if(self.userManager.friendUsers.count > 0){
//                print(self.userManager.friendUsers[0].getLocation())
//            }
//        }
//
//        print("userlocationdata: ", self.userLocationData)
//    }
//}

//
//  ViewController.swift
//  familyclock
//
//  Created by Alexis Ferrante on 4/23/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//




//////////////////////////////////////////////////////////////////////////



//import UIKit
//import FirebaseDatabase
//import Firebase
//import FirebaseFirestore
//import GoogleSignIn
//import MapKit
//import CoreLocation
//
//class ViewController: UIViewController, CLLocationManagerDelegate {
//
//    @IBOutlet weak var imageOutlet: UIImageView!
//
//    let locationManager = CLLocationManager()
//    let db = Firestore.firestore()
//    let ref = Database.database().reference()
//    let user = Auth.auth().currentUser
//    var userManager = UserManager()
//    var userLocationData : [(String, (CLLocationDegrees, CLLocationDegrees))] = []
//
//    var anchor: UIView! = UIView.init()
//    var anchor2: UIView! = UIView.init()
//    var anchor3: UIView! = UIView.init()
//    var anchor4: UIView! = UIView.init()
//    var anchor5: UIView! = UIView.init()
//    var anchor6: UIView! = UIView.init()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //map stuff
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//
//        print(userManager.user?.uid)
//        userManager.isNewUser{ isNewUser in
//            if(isNewUser && self.userLocationData.isEmpty){
//                print("user didn't exist: transition to map select view")
//                self.performSegue(withIdentifier: "clockToLocationSelect", sender: self)
//            }
//        }
//
////        if(!userLocationData.isEmpty){
////            userLocationData.insert(("current", (locationManager.location?.coordinate.longitude ?? 0.0, locationManager.location?.coordinate.latitude ?? 0.0)), at: 0)
////
////            userManager.initializeIfNewUser(locationData: userLocationData){ isNewUser in
////                print("initializing: is new user? ", isNewUser)
////            }
////        }
//
//        anchor = createAnchor(anchor: anchor)
//        anchor.backgroundColor = UIColor.orange
//        anchor2 = createAnchor(anchor: anchor2)
//        anchor2.backgroundColor = UIColor.red
//        anchor3 = createAnchor(anchor: anchor3)
//        anchor3.backgroundColor = UIColor.green
//        anchor4 = createAnchor(anchor: anchor4)
//        anchor4.backgroundColor = UIColor.cyan
//        anchor5 = createAnchor(anchor: anchor5)
//        anchor5.backgroundColor = UIColor.magenta
//        anchor6 = createAnchor(anchor: anchor6)
//        anchor6.backgroundColor = UIColor.yellow
//        rotate()
//
//
//    }
//
//    func createAnchor(anchor: UIView) -> UIView {
//        let anchorLength = 110
//        anchor.center = self.view.center
//        anchor.layer.bounds = CGRect(x: 0, y: 0, width: 3, height: anchorLength)
//        anchor.layer.anchorPoint = CGPoint(x: 1, y: 1)
//        anchor.layer.cornerRadius = 1
//        self.view.addSubview(anchor)
//        return anchor
//    }
//
//    func rotate() {
//
//        UIView.animate(withDuration: 3) {
//            self.anchor2.transform = CGAffineTransform(rotationAngle: .pi / 3.2)
//            self.anchor3.transform = CGAffineTransform(rotationAngle: .pi)
//            self.anchor4.transform = CGAffineTransform(rotationAngle: -.pi / 3.5)
//            self.anchor5.transform = CGAffineTransform(rotationAngle: .pi / 1.5)
//            self.anchor6.transform = CGAffineTransform(rotationAngle: -.pi / 1.5)
//        }
//
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        if UIDevice.current.orientation.isLandscape {
//            anchor.center = self.view.center
//        }
//    }
//
//}
//
//class MyView: UIView {
//
//
//    override func draw(_ rect: CGRect) {
//        let ctx = UIGraphicsGetCurrentContext()!
//
//        ctx.translateBy (x: self.frame.size.width / 2, y: self.frame.size.height / 2)
//        ctx.scaleBy (x: 1, y: -1)
//
//        drawText(context: ctx, text: "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", radius: 198, angle: -.pi / 5.5, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 18)!, flip: false)
//        drawText(context: ctx, text: "HOME 🏠", radius: 165, angle: -.pi / 5.8, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: false)
//        drawText(context: ctx, text: "WORK 🗄️", radius: 160, angle: .pi / 5.5, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
//        drawText(context: ctx, text: "LOST ❓", radius: 160, angle: .pi / 2, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
//        drawText(context: ctx, text: "SCHOOL 🏫", radius: 160, angle: -.pi / 2, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: false)
//        drawText(context: ctx, text: "GYM 💪🏼", radius: 160, angle: .pi / 0.85, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: false)
//        drawText(context: ctx, text: "CLINIC 🏥", radius: 160, angle: -.pi / 0.85, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
//    }
//
//    func drawText(context: CGContext, text str: String, radius r: CGFloat, angle delta: CGFloat, color c: UIColor, font: UIFont, flip: Bool){
//
//
//        let characters: [String] = str.map { String($0) }
//        let charsAmount = characters.count
//        let attributes = [NSAttributedString.Key.font: font]
//
//        var word: [CGFloat] = []
//        var totalWords: CGFloat = 0
//
//
//        for i in 0 ..< charsAmount {
//            word += [distanceToWord(characters[i].size(withAttributes: attributes).width, radius: r)]
//            totalWords += word[i]
//        }
//
//        let direction: CGFloat = flip ? -1 : 1
//        let slope: CGFloat = flip ? -.pi / 2 : .pi / 2
//
//        var theta = delta - direction * totalWords / 2
//
//        for i in 0 ..< charsAmount {
//            theta += direction * word[i] / 2
//
//            center(context: context, text: characters[i], radius: r, angle: theta, colour: c, font: font, inclination: theta + slope)
//
//            theta += direction * word[i] / 2
//        }
//    }
//
//    func distanceToWord(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
//
//        return asin(chord / (radius * 2)) * 2
//    }
//
//    func center(context: CGContext, text str: String, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, inclination: CGFloat) {
//
//        let attributes = [NSAttributedString.Key.foregroundColor: c, NSAttributedString.Key.font: font]
//        let wordOffset = str.size(withAttributes: attributes)
//
//        context.saveGState()
//        context.scaleBy(x: 1, y: -1)
//        context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
//        context.rotate(by: -inclination)
//
//        context.translateBy (x: -wordOffset.width / 2, y: -wordOffset.height / 2)
//        str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
//        context.restoreGState()
//    }
//}

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import GoogleSignIn
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    let locationManager = CLLocationManager()
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser
    var userManager = UserManager()
    var userLocationData : [(String, (CLLocationDegrees, CLLocationDegrees))] = []
    
    var anchor: UIView! = UIView.init()
    var anchor2: UIView! = UIView.init()
    var anchor3: UIView! = UIView.init()
    var anchor4: UIView! = UIView.init()
    var anchor5: UIView! = UIView.init()
    var anchor6: UIView! = UIView.init()
    var lostAngle: CGFloat =  .pi * 2
    var workAngle: CGFloat =  .pi / 3.2
    var homeAngle: CGFloat =  .pi / 1.5
    var schoolAngle: CGFloat =  .pi
    var gymAngle: CGFloat =  -.pi / 1.5
    var clinicAngle: CGFloat =  -.pi / 3.5
    var users : [User] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userManager.isNewUser{ isNewUser in
            if(isNewUser && self.userLocationData.isEmpty){
                print("user didn't exist: transition to map select view")
                self.performSegue(withIdentifier: "clockToLocationSelect", sender: self)
            }
        }
        
//        userManager.addFriend(friendEmail: "ginacalenti67@gmail.com"){
//            
//        }
        
        userManager.getFriendsLocations { userNumber, fu in
            self.userManager.friendUsers = fu
//            self.users = self.userManager.friendUsers
//            let userNumber = self.users.count
            print("VDL users", self.userManager.friendUsers.map({$0.email}))
            print("FU", fu.map({$0.email}))
            print("VDL user number", userNumber)
            
            
            if (userNumber == 1) {
                self.anchor = self.createAnchor(anchor: self.anchor)
                self.anchor.backgroundColor = UIColor.orange
            } else if (userNumber == 2) {
                self.anchor = self.createAnchor(anchor: self.anchor)
                self.anchor.backgroundColor = UIColor.orange
                self.anchor2 = self.createAnchor(anchor: self.anchor2)
                self.anchor2.backgroundColor = UIColor.red
            } else if (userNumber == 3) {
                self.anchor = self.createAnchor(anchor: self.anchor)
                self.anchor.backgroundColor = UIColor.orange
                self.anchor2 = self.createAnchor(anchor: self.anchor2)
                self.anchor2.backgroundColor = UIColor.red
                self.anchor3 = self.createAnchor(anchor: self.anchor3)
                self.anchor3.backgroundColor = UIColor.green
            } else if (userNumber == 4) {
                self.anchor = self.createAnchor(anchor: self.anchor)
                self.anchor.backgroundColor = UIColor.orange
                self.anchor2 = self.createAnchor(anchor: self.anchor2)
                self.anchor2.backgroundColor = UIColor.red
                self.anchor3 = self.createAnchor(anchor: self.anchor3)
                self.anchor3.backgroundColor = UIColor.green
                self.anchor4 = self.createAnchor(anchor: self.anchor4)
                self.anchor4.backgroundColor = UIColor.cyan
            } else if (userNumber == 5) {
                self.anchor = self.createAnchor(anchor: self.anchor)
                self.anchor.backgroundColor = UIColor.orange
                self.anchor2 = self.createAnchor(anchor: self.anchor2)
                self.anchor2.backgroundColor = UIColor.red
                self.anchor3 = self.createAnchor(anchor: self.anchor3)
                self.anchor3.backgroundColor = UIColor.green
                self.anchor4 = self.createAnchor(anchor: self.anchor4)
                self.anchor4.backgroundColor = UIColor.cyan
                self.anchor5 = self.createAnchor(anchor: self.anchor5)
                self.anchor5.backgroundColor = UIColor.magenta
            } else if (userNumber == 6) {
                self.anchor = self.createAnchor(anchor: self.anchor)
                self.anchor.backgroundColor = UIColor.orange
                self.anchor2 = self.createAnchor(anchor: self.anchor2)
                self.anchor2.backgroundColor = UIColor.red
                self.anchor3 = self.createAnchor(anchor: self.anchor3)
                self.anchor3.backgroundColor = UIColor.green
                self.anchor4 = self.createAnchor(anchor: self.anchor4)
                self.anchor4.backgroundColor = UIColor.cyan
                self.anchor5 = self.createAnchor(anchor: self.anchor5)
                self.anchor5.backgroundColor = UIColor.magenta
                self.anchor6 = self.createAnchor(anchor: self.anchor6)
                self.anchor6.backgroundColor = UIColor.yellow
            }
            
        }
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        userManager.getFriendsLocations { userNumber, fu in
            self.userManager.friendUsers = fu
            
//            self.users = self.userManager.friendUsers
//            //print("users", self.users.map({$0.currentLocation}))
//            let userNumber = self.users.count
            
            print("VWA users", self.userManager.friendUsers.map({$0.email}))
            print("VWA user number", userNumber)
            
            if (userNumber == 1) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor)
                }
            } else if (userNumber == 2) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor)
                    self.assignAnchorToLocation(anchor: self.anchor2)
                }
            } else if (userNumber == 3) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor)
                    self.assignAnchorToLocation(anchor: self.anchor2)
                    self.assignAnchorToLocation(anchor: self.anchor3)
                }
            } else if (userNumber == 4) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor)
                    self.assignAnchorToLocation(anchor: self.anchor2)
                    self.assignAnchorToLocation(anchor: self.anchor3)
                    self.assignAnchorToLocation(anchor: self.anchor4)
                }
            } else if (userNumber == 5) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor)
                    self.assignAnchorToLocation(anchor: self.anchor2)
                    self.assignAnchorToLocation(anchor: self.anchor3)
                    self.assignAnchorToLocation(anchor: self.anchor4)
                    self.assignAnchorToLocation(anchor: self.anchor5)
                }
            } else if (userNumber == 6) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor)
                    self.assignAnchorToLocation(anchor: self.anchor2)
                    self.assignAnchorToLocation(anchor: self.anchor3)
                    self.assignAnchorToLocation(anchor: self.anchor4)
                    self.assignAnchorToLocation(anchor: self.anchor5)
                    self.assignAnchorToLocation(anchor: self.anchor6)
                }
            }
        }
    }
    
    func createAnchor(anchor: UIView) -> UIView {
        let anchorLength = 110
        anchor.center = self.view.center
        anchor.layer.bounds = CGRect(x: 0, y: 0, width: 3, height: anchorLength)
        anchor.layer.anchorPoint = CGPoint(x: 1, y: 1)
        anchor.layer.cornerRadius = 1
        self.view.addSubview(anchor)
        return anchor
    }
    
    
    func assignAnchorToLocation(anchor: UIView) {
        print("assign anchor called")
        users = userManager.friendUsers
        print("fjkfjkejke", users.map({$0.email}))
        for location in users {
            let position = location.getLocation()
            print("position:", position)
            if (position == "work") {
                anchor.transform = CGAffineTransform(rotationAngle: self.workAngle)
            } else if (position == "school") {
                anchor.transform = CGAffineTransform(rotationAngle: self.schoolAngle)
            } else if (position == "dentist") {
                anchor.transform = CGAffineTransform(rotationAngle: self.clinicAngle)
            } else if (position == "home") {
                anchor.transform = CGAffineTransform(rotationAngle: self.homeAngle)
            } else if (position == "gym") {
                anchor.transform = CGAffineTransform(rotationAngle: self.gymAngle)
            } else {
                anchor.transform = CGAffineTransform(rotationAngle: self.lostAngle)
            }
        }
    }
    
    
}

class MyView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.translateBy (x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        ctx.scaleBy (x: 1, y: -1)
        
        drawText(context: ctx, text: "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", radius: 198, angle: -.pi / 5.5, color: UIColor.black, font: UIFont.init(name: "Zapfino", size: 18)!, flip: false)
        drawText(context: ctx, text: "HOME 🏠", radius: 165, angle: -.pi / 5.8, color: UIColor.black, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
        drawText(context: ctx, text: "WORK 🗄️", radius: 160, angle: .pi / 5.5, color: UIColor.black, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
        drawText(context: ctx, text: "LOST ❓", radius: 160, angle: .pi / 2, color: UIColor.black, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
        drawText(context: ctx, text: "SCHOOL 🏫", radius: 160, angle: -.pi / 2, color: UIColor.black, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
        drawText(context: ctx, text: "GYM 💪🏼", radius: 160, angle: .pi / 0.85, color: UIColor.black, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
        drawText(context: ctx, text: "DENTIST 🏥", radius: 160, angle: -.pi / 0.85, color: UIColor.black, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
    }
    
    func drawText(context: CGContext, text str: String, radius r: CGFloat, angle delta: CGFloat, color c: UIColor, font: UIFont, flip: Bool){
        
        
        let characters: [String] = str.map { String($0) }
        let charsAmount = characters.count
        let attributes = [NSAttributedString.Key.font: font]
        
        var word: [CGFloat] = []
        var totalWords: CGFloat = 0
        
        
        for i in 0 ..< charsAmount {
            word += [distanceToWord(characters[i].size(withAttributes: attributes).width, radius: r)]
            totalWords += word[i]
        }
        
        let direction: CGFloat = flip ? -1 : 1
        let slope: CGFloat = flip ? -.pi / 2 : .pi / 2
        
        var delta = delta - direction * totalWords / 2
        
        for i in 0 ..< charsAmount {
            delta += direction * word[i] / 2
            
            center(context: context, text: characters[i], radius: r, angle: delta, colour: c, font: font, inclination: delta + slope)
            
            delta += direction * word[i] / 2
        }
    }
    
    func center(context: CGContext, text str: String, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, inclination: CGFloat) {
        
        let attributes = [NSAttributedString.Key.foregroundColor: c, NSAttributedString.Key.font: font]
        let wordOffset = str.size(withAttributes: attributes)
        
        context.saveGState()
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
        context.rotate(by: -inclination)
        
        context.translateBy (x: -wordOffset.width / 2, y: -wordOffset.height / 2)
        str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        context.restoreGState()
    }
    
    func distanceToWord(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
        
        return asin(chord / (radius * 2)) * 2
    }
}

