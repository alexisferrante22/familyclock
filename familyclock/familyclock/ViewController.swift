//
//  ViewController.swift
//  familyclock
//
//  Created by Alexis Ferrante on 4/23/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.

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
        
        self.performSegue(withIdentifier: "clockToLocationSelect", sender: self)
        
        userManager.isNewUser{ isNewUser in
            if(isNewUser && self.userLocationData.isEmpty){
                print("user didn't exist: transition to map select view")
                self.performSegue(withIdentifier: "clockToLocationSelect", sender: self)
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        userManager.getFriendsLocations { userNumber, fu in
            self.userManager.friendUsers = fu
            print(fu.count)
            
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
            
            if (userNumber == 1) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor, userIndex: 0)
                }
            } else if (userNumber == 2) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor, userIndex: 0)
                    self.assignAnchorToLocation(anchor: self.anchor2, userIndex: 1)
                }
            } else if (userNumber == 3) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor, userIndex: 0)
                    self.assignAnchorToLocation(anchor: self.anchor2, userIndex: 1)
                    self.assignAnchorToLocation(anchor: self.anchor3, userIndex: 2)
                }
            } else if (userNumber == 4) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor, userIndex: 0)
                    self.assignAnchorToLocation(anchor: self.anchor2, userIndex: 1)
                    self.assignAnchorToLocation(anchor: self.anchor3, userIndex: 2)
                    self.assignAnchorToLocation(anchor: self.anchor4, userIndex: 3)
                }
            } else if (userNumber == 5) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor, userIndex: 0)
                    self.assignAnchorToLocation(anchor: self.anchor2, userIndex: 1)
                    self.assignAnchorToLocation(anchor: self.anchor3, userIndex: 2)
                    self.assignAnchorToLocation(anchor: self.anchor4, userIndex: 3)
                    self.assignAnchorToLocation(anchor: self.anchor5, userIndex: 4)
                }
            } else if (userNumber == 6) {
                UIView.animate(withDuration: 3) {
                    self.assignAnchorToLocation(anchor: self.anchor, userIndex: 0)
                    self.assignAnchorToLocation(anchor: self.anchor2, userIndex: 1)
                    self.assignAnchorToLocation(anchor: self.anchor3, userIndex: 2)
                    self.assignAnchorToLocation(anchor: self.anchor4, userIndex: 3)
                    self.assignAnchorToLocation(anchor: self.anchor5, userIndex: 4)
                    self.assignAnchorToLocation(anchor: self.anchor6, userIndex: 5)
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
    
    
    func assignAnchorToLocation(anchor: UIView, userIndex: Int) {
        users = userManager.friendUsers
        let location = users[userIndex]
            let position = location.getLocation()
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

