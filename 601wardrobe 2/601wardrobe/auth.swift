//
//  auth.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 10/29/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import KeychainSwift

class auth: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLabel.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataService().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "goToHome", sender: nil)
        }
    }
    
    func CompleteSignIn (id: String) {
        let keyChain = DataService().keyChain
        keyChain.set( id, forKey: "uid")
    }
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        //Flipped boolean
        isSignIn = !isSignIn
        if isSignIn {
            signInLabel.text = "Sign in with your Email & Password"
            signInButton.setTitle("Sign In", for: .normal)
            errorMessageLabel.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
        }
        else {
            signInLabel.text = "Register with your Email"
            signInButton.setTitle("Register", for: .normal)
            errorMessageLabel.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
        }
        
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // Check if textfields are empty or not, format of email and password is right
        if let email = emailTextField.text, let pass = passwordTextField.text {
            // Check if it is sign in or register
            if isSignIn {
                //sign in with Firebase
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    // Check user isn't nil
                    if error == nil {
                        self.CompleteSignIn(id: user!.uid)
                        // If user is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error: check error, show message
                        self.errorMessageLabel.text = "Email or Password is invalid"
                        print("Can't sign in user!")
                    }
                })
            }
            else {
                //Register user with Firebase
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    // Check user isn't nil
                    if error == nil {
                        self.CompleteSignIn(id: user!.uid)
                        // User is found go to homescreen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        //Error: check error, show message
                        self.errorMessageLabel.text = "Email is invalid or already registered"
                    }
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 100, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 100, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }

}
