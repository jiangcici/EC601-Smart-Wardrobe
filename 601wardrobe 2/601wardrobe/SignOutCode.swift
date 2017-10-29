//
//  SignOutCode.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 10/29/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift
import FirebaseAuth
import FirebaseDatabase

class SignOutCode: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SignOut (_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        //Remove keycahin
        DataService().keyChain.delete("uid")
        dismiss(animated: true, completion: nil)
    }
    

}
