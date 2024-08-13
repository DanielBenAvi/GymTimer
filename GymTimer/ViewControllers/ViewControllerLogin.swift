
import Foundation
import UIKit
import FirebaseAuth

class ViewControllerLogin: UIViewController {
    
    
    @IBOutlet weak var login_ET_email: UITextField!
    
    
    
    @IBOutlet weak var login_ET_password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            print("User is already logged in")
            self.moveToNewScreen(storyboard_id: "ViewControllerWorkouts")
        } else {
            print("User is not logged in")
        }
    }
    
    
    @IBAction func action_login(_ sender: Any) {
        let email = login_ET_email.text
        let password = login_ET_password.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) {
            (authResult, error) in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            } else {
                print("User logged in successfully")
                
                self.moveToNewScreen(storyboard_id: "ViewControllerWorkouts")
            }
        }
        
    }

}



