//
//  ViewControllerCreateWorkout.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import Foundation
import UIKit

class ViewControllerCreateWorkout: UIViewController {
    
            
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func add_new_exercise(_ sender: Any) {
        
        self.moveToNewScreen(storyboard_id: "ViewControllerAddExercise")
        
    }
}
