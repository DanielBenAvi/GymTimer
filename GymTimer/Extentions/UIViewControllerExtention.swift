import Foundation
import UIKit

extension UIViewController {
    func moveToNewScreen(storyboard_id: String, fullScreen: Bool = false){
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboard_id)
        if fullScreen {
            newViewController.modalPresentationStyle = .fullScreen
        }
        self.present(newViewController, animated: false, completion: nil)
    }
    
    func addAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.tintColor = UIColor(named: "MyAccent")
        self.present(alert, animated: true)
    }

}
