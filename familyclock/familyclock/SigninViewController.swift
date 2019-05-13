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
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = titleLabel.font.withSize(35)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().disconnect()
    }
    
    @IBAction func signInButton(_ sender: Any) {
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
}
