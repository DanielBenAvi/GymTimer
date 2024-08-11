//
//  UIViewControllerExtention.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import Foundation
import UIKit

extension UIViewController {
    func moveToNewScreen(storyboard_id: String){
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboard_id)
        newViewController.modalPresentationStyle = .fullScreen // or .overFullScreen
        self.present(newViewController, animated: true)
    }
}
