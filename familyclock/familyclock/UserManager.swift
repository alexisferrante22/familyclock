//
//  UserManager.swift
//  familyclock
//
//  Created by Alexis Ferrante on 4/26/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import GoogleSignIn
import CoreLocation

class UserManager {
    
    let dbRef = Firestore.firestore().collection("users")
    var friendUsers : [User] = []
    let user = Auth.auth().currentUser
    let validLocations = ["current", "home", "work", "school", "dentist", "gym"]
    let NUM_ALLOWED_FRIENDS = 6
    //let ACCEPTABLE_DISTANCE_FROM_LOCATION_METERS = 10

    /* returns true if user is new and data has been initialized, false if user already existed in database. initializes user in DB with location data that is passed in as a parameter
     */
    func initializeIfNewUser(locationData: [(String,(CLLocationDegrees, CLLocationDegrees))], completion: @escaping (Bool) -> Void) {
        let docRef = dbRef.document((user?.uid)!)
        var isNewUser = true
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                isNewUser = false
            } else {
                //initialize user's location data - select from map?
                isNewUser = true
                self.updateUserEmailInDB {
                    for (locationLabel, (longitude, latitude)) in locationData{
                        print(locationLabel, longitude, latitude)
                        docRef.collection("locations").addDocument(data: ["locationType":locationLabel, "latitude": latitude, "longitude": longitude])
                    }
                }
            }
            completion(isNewUser)
        }
    }
    
    func isNewUser(completion: @escaping (Bool) -> Void) {
        let docRef = dbRef.document((user?.uid)!)
        var exists = true
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                exists = false
            } else {
                exists = true
            }
            completion(exists)
        }
    }
    
    
    /* returns the list of email addresses that are in this user's friends list. This function is primarily being used to
     aggregate these email addresses so we can query the users in the DB associted with each email address to
     obtain their location data.
     */
    func getFriendsEmails(completion: @escaping ([String]) -> Void) {
        let query = dbRef.document((user?.uid)!).collection("friends")
        query.getDocuments { snapshot, error in
            print(error ?? "No error.")
            var friendEmails : [String] = []
            guard let snapshot = snapshot else {
                completion(friendEmails)
                return
            }
            for doc in snapshot.documents {
                if(!friendEmails.contains(doc.data()["email"] as! String)){
                    friendEmails.append(doc.data()["email"] as! String)
                }
            }
            completion(friendEmails)
        }
    }
    
    /* Given a reference to a user document in the DB and a location type (e.g. "home", "work", etc.), fetches
     the coordinates for that location for the user. Mostly being used in the GetFriendsLocations function to aggregate
     all friend data
     */
    func getLocationTypeCoordsForUser(userDocumentReference : DocumentReference, locationType : String, completion: @escaping ((CLLocationDegrees, CLLocationDegrees)) -> Void) {
        let query = userDocumentReference.collection("locations").whereField("locationType", isEqualTo: locationType)
        query.getDocuments { snapshot, error in
            print(error ?? "No error.")
            guard let snapshot = snapshot else {
                completion((9.0, 9.0)) //dummy unused value
                return
            }
            var currentLocCoords : (CLLocationDegrees, CLLocationDegrees) = (0.0, 0.0)
//            let data = snapshot.documents[0].data()
//            let currentLocCoords = (data["longitude"], data["latitude"]) as! (CLLocationDegrees, CLLocationDegrees)
            for doc in snapshot.documents {
                //print("ADJFHJSJDJDJDJDJJDJDJ", doc.data())
                currentLocCoords = (doc.data()["longitude"], doc.data()["latitude"]) as! (CLLocationDegrees, CLLocationDegrees)

            }
//            print(locationType)
//            print(userDocumentReference.path)
//            print("current loc coords:", currentLocCoords)
            completion(currentLocCoords)
        }
    }
    
    /* This function fetches all location data for all friends of the current user and creates a User object for each friend.
     It populates the instance variable array friendUsers with these user objects for ease of use in the view controller.
     */
    func getFriendsLocations(completion: @escaping (Int, [User]) -> Void) {
        var index = 0
        self.friendUsers = []
        var fu : [User] = []
        getFriendsEmails{friendEmails in
            for emailAddress in friendEmails {
                let query = self.dbRef.whereField("email", isEqualTo: emailAddress)
                query.getDocuments { snapshot, error in
                    print(error ?? "No error.")
                    guard let snapshot = snapshot else {
                        completion(0, [])
                        return
                    }
                    //for doc in snapshot.documents {
                    let doc = snapshot.documents[0]
                        self.getLocationTypeCoordsForUser(userDocumentReference: doc.reference, locationType: "current"){(currfetchedLong, currfetchedLat) in
                            self.getLocationTypeCoordsForUser(userDocumentReference: doc.reference, locationType: "work"){(workfetchedLong, workfetchedLat) in
                                self.getLocationTypeCoordsForUser(userDocumentReference: doc.reference, locationType: "school"){(schoolfetchedLong, schoolfetchedLat) in
                                    self.getLocationTypeCoordsForUser(userDocumentReference: doc.reference, locationType: "gym"){(gymfetchedLong, gymfetchedLat) in
                                        self.getLocationTypeCoordsForUser(userDocumentReference: doc.reference, locationType: "dentist"){(dentistfetchedLong, dentistfetchedLat) in
                                            self.getLocationTypeCoordsForUser(userDocumentReference: doc.reference, locationType: "home"){(homefetchedLong, homefetchedLat) in
                                                index += 1
                                                //print("index: \(index), friendemails.count: \(friendEmails.count)")
                                                let friendUser = User(emailAddress: emailAddress)
                                                friendUser.currentLocation = (currfetchedLong, currfetchedLat)
                                                friendUser.workLocation = (workfetchedLong, workfetchedLat)
                                                friendUser.schoolLocation = (schoolfetchedLong, schoolfetchedLat)
                                                friendUser.gymLocation = (gymfetchedLong, gymfetchedLat)
                                                friendUser.dentistLocation = (dentistfetchedLong, dentistfetchedLat)
                                                friendUser.homeLocation = (homefetchedLong, homefetchedLat)
                                                self.friendUsers.append(friendUser)
                                                fu.append(friendUser)
                                                
                                                if(index == friendEmails.count){
                                                    completion(friendEmails.count, fu)
                                                }
                                                //print("get friends locations", friendUser.dentistLocation)
                                                //                            print(self.friendUsers.map{$0.email}, self.friendUsers.map{$0.currentLongitude}, self.friendUsers.map{$0.currentLatitude})
                                            }
                                        }
                                    }
                                }
                            }
                        }
                }
            }
            if(friendEmails.count == 0){
                completion(0,[])
            }
        }
    }
    
    
    /* Writes a user's location data to the database for a specified location type (i.e. "home")
     */
    func updateUserLocationInDB(locationType : String, longitude : CLLocationDegrees, latitude : CLLocationDegrees, completion: @escaping () -> Void) {
        if(user != nil){
            if(validLocations.contains(locationType)){
                dbRef.document((user?.uid)!).collection("locations").document(locationType).setData([
                    "locationType": locationType,
                    "longitude": longitude,
                    "latitude": latitude,
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                        completion()
                }
            } else {
                print("\(locationType) is not a valid Location Type")
                completion()
            }
        }
    }
    
    /* adds a user's email address to the database */
    func updateUserEmailInDB(completion: @escaping () -> Void) {
        if(user != nil){
            dbRef.document((user?.uid)!).setData([
                "email": user?.email,
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                    completion()
            }
        }
    }
    
    /* returns number of friends in the current user's friend list */
    func getNumberOfFriends(completion: @escaping (Int) -> Void) {
        if(user != nil){
            dbRef.document((user?.uid)!).collection("friends").getDocuments { (snapshot, error) in
                print(error ?? "No error.")
                guard let snapshot = snapshot else {
                    return
                }
                completion(snapshot.count)
            }
        }
    }
    
    /* adds a friend's email to the current user's list of friends in the DB */
    func addFriend(friendEmail : String, completion: @escaping () -> Void) {
        if(user != nil){
            getNumberOfFriends{ numFriends in
                if(numFriends < self.NUM_ALLOWED_FRIENDS){
                    self.dbRef.document((self.user?.uid)!).collection("friends").addDocument(data: ["email": friendEmail])
                } else {
                    print("did not add \(friendEmail) as friend - you already have too many friends")
                }
                completion()
            }
        }
    }
    
    /* adds a friend's email to the current user's list of friends in the DB */
    func deleteFriend(friendEmail : String, completion: @escaping () -> Void) {
        if(user != nil){
            getNumberOfFriends{ numFriends in
                self.dbRef.document((self.user?.uid)!).collection("friends").getDocuments() { (snapshot, error) in
                    print(error ?? "No error.")
                    guard let snapshot = snapshot else {
                        return
                    }
                    for doc in snapshot.documents{
                        if (doc.data()["email"] as! String == friendEmail){
                            print(doc.description)
                        }
                    }
                }
                //data: ["email": friendEmail]
                completion()
            }
        }
    }
}


/* class used to store user data so it is easily accessed from the view controllers.
Through functions like GetFriendsLocations, data from the DB is read and stored in
User objects */
class User {
    var email : String = ""
    // location tuples are in the format of (longitude, latitude)
    var currentLocation : (CLLocationDegrees, CLLocationDegrees) = (0.0,0.0)
    var homeLocation : (CLLocationDegrees, CLLocationDegrees) = (0.0,0.0)
    var workLocation : (CLLocationDegrees, CLLocationDegrees) = (0.0,0.0)
    var schoolLocation : (CLLocationDegrees, CLLocationDegrees) = (0.0,0.0)
    var gymLocation : (CLLocationDegrees, CLLocationDegrees) = (0.0,0.0)
    var dentistLocation : (CLLocationDegrees, CLLocationDegrees) = (0.0,0.0)
    
    init(emailAddress : String){
        email = emailAddress
    }
    
    /* function that returns the appropriate location type of a User at a given time.
     */
    
    func getLocation() -> String {
        let currentLocation = CLLocation(latitude: self.currentLocation.1, longitude: self.currentLocation.0)
        let locations = [("home", homeLocation), ("work", workLocation), ("school", schoolLocation), ("gym", gymLocation), ("dentist", dentistLocation)]
        
        for (label,(long, lat)) in locations {
            let newLocation = CLLocation(latitude: lat, longitude: long)
            let distance = newLocation.distance(from: currentLocation)
//            print(self.email)
//            print(label,long,lat, " distance from current: ", distance)
            if(distance <= 10){
                //print(self.email, label)
                return label
            }
        }
        return "lost"
    }
}

