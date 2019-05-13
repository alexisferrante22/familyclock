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
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addFriendTextField: UITextField!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var deleteFriendTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = titleLabel.font.withSize(25)
        if let currUser = userManager.user {
            userLabel.text = "Account: \(currUser.email!)"
        }
    }
    
    @IBAction func addFriendAction(_ sender: Any) {
        if let emailToAdd = addFriendTextField.text {
            userManager.addFriend(friendEmail: emailToAdd){
                print("adding \(emailToAdd)")
                let alert = UIAlertController(title: "Friends:", message: "\(emailToAdd) added", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true)
                self.addFriendTextField.text = ""
            }
        }
    }
    
    
    @IBAction func deleteFriendAction(_ sender: Any) {
        if let emailToDelete = deleteFriendTextField.text {
            userManager.deleteFriend(friendEmail: emailToDelete){
                print("deleting \(emailToDelete)")
                let alert = UIAlertController(title: "Friends:", message: "\(emailToDelete) deleted", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true)
                self.deleteFriendTextField.text = ""
            }
        }
    }
    

    
    @IBAction func SignOutButtonPress(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try
                firebaseAuth.signOut()
            self.performSegue(withIdentifier: "accountToSignInSegue", sender: self)
                
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
