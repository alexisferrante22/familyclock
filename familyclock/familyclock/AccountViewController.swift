//
//  AccountViewController.swift
//  familyclock
//
//  Created by Alexis Ferrante on 5/7/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class AccountViewController: UIViewController {
    
    var userManager = UserManager()
    @IBOutlet weak var addFriendTextField: UITextField!
    @IBOutlet weak var addFriendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SignOutButtonPress(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try
                firebaseAuth.signOut()
//                GIDSignIn.sharedInstance().signOut()
//                GIDSignIn.sharedInstance().disconnect()
            self.performSegue(withIdentifier: "accountToSignInSegue", sender: self)
                
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
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
