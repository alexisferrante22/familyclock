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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            if user != nil {
                //MeasurementHelper.sendLoginEvent()
                self.performSegue(withIdentifier: "signInToTabBarSegue", sender: self)
            }
        }
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...

        // Do any additional setup after loading the view.
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
