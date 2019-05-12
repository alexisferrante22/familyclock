//
//  SigninViewController.swift
//  familyclock
//
//  Created by Alexis Ferrante on 4/23/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class SigninViewController: UIViewController, GIDSignInUIDelegate {

    var handle: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var googleButton: GIDSignInButton!
    
    @IBOutlet weak var goButton: UIButton!
    
//    override func viewWillAppear(_ animated: Bool) {
//        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
//            if user != nil {
//                //MeasurementHelper.sendLoginEvent()
//                self.performSegue(withIdentifier: "signInToTabBarSegue", sender: self)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().disconnect()

//        googleButton.frame = CGRect(x: 16, y:116+66, width: view.frame.width - 32, height: 50)
//        view.addSubview(googleButton)
//        googleButton.addTarget(self, action: #selector (handleGoogleSignIn), for: .touchUpInside)
        
//        GIDSignIn.sharedInstance().signIn()

//        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
//            if user != nil {
//                print("state changed")
//                self.performSegue(withIdentifier: "signInToTabBarSegue", sender: self)
//            }
//        }
    }
    
    @IBAction func signInButton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "signInToTabBarSegue", sender: self)
        }
    }
    
    @objc func handleGoogleSignIn(){
        print("new button press")
        GIDSignIn.sharedInstance().signIn()
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "signInToTabBarSegue", sender: self)
        }
    }
    
    @IBAction func signInButtonPress(_ sender: Any) {
        print("sign in pressed")
        GIDSignIn.sharedInstance().signIn()
        
        if Auth.auth().currentUser != nil {
            goButton.isHidden = false
            self.performSegue(withIdentifier: "signInToTabBarSegue", sender: self)
        }
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
