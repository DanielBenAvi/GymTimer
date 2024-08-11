import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewControllerRegister: UIViewController {

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
        
        
        // upload the user to firebase
        Auth.auth().createUser(withEmail: email!, password: password!) {
            (authResult, error) in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            } else {
                print("User created successfully")
                
                // create a user object
                let user = User(id: authResult!.user.uid, name: username!, email: email!, password: password!)
                
                
                // upload the user to the database
                let ref = Database.database().reference()
                
                print(ref)
                
                ref.child("users").child(user.id).setValue(user.toDictionary(), withCompletionBlock: {
                    (error, ref) in
                    if error != nil {
                        print("Error: \(error!.localizedDescription)")
                    } else {
                        print("User uploaded successfully")
                        
                        
                        // move to the workouts screen
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "workouts_screen")
                        self.present(vc, animated: true, completion: nil)
                    
                    }
                })
            }
        }
    }
    
}

