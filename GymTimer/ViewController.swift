//
//  ViewController.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var register_LBL_title: UILabel!
    
    @IBOutlet weak var register_ET_email: UITextField!
    
    @IBOutlet weak var register_ET_username: UITextField!
    
    @IBOutlet weak var register_ET_password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func action_register(_ sender: Any) {
        // Get the values from the text fields
        let email = register_ET_email.text
        let username = register_ET_username.text
        let password = register_ET_password.text
        
        
        // Create a new user object
        let user = User(name: username!, email: email!, password: password!)
        
        // upload the user to firebase
        Auth.auth().createUser(withEmail: email!, password: password!) {
            (authResult, error) in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            } else {
                print("User created successfully")
            }
        }
    }
    
}

