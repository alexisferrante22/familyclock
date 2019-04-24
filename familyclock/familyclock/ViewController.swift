//
//  ViewController.swift
//  familyclock
//
//  Created by Alexis Ferrante on 4/23/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let ref = Database.database().reference()
        
        //set data
        ref.child("someid").setValue("alexis")
        // Do any additional setup after loading the view, typically from a nib.
        
        //retrieve data
        ref.child("someid").observeSingleEvent(of: .value){
            (snapshot) in
            let name = snapshot.value as? String
            print(name)
        }
    }


}

