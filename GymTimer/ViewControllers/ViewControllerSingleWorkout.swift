//
//  ViewControllerSingleWorkout.swift
//  GymTimer
//
//  Created by Yaniv Ben David on 12/08/2024.
//

import Foundation
import UIKit

class ViewControllerSingleWorkout: UIViewController {
        
    @IBOutlet weak var workout_LBL_name: UINavigationItem!
    
    var workout: Workout!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        
            workout_LBL_name.title = workout.name
    }
    
}

