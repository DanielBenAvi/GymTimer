//
//  ViewControllerAddExercise.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import Foundation
import UIKit

class ViewControllerAddExercise : UIViewController {
    
    @IBOutlet weak var addExercise_TF_name: UITextField!
    
    @IBOutlet weak var addExercise_LBL_sets: UILabel!
    @IBOutlet weak var addExercise_STP_sets: UIStepper!
    
    @IBOutlet weak var addExercise_LBL_reps: UILabel!
    @IBOutlet weak var addExercise_STP_reps: UIStepper!
    
    @IBOutlet weak var addExercise_LBL_weight: UILabel!
    @IBOutlet weak var addExercise_SLD_weight: UISlider!
    
    @IBOutlet weak var addExercise_LBL_break: UILabel!
    @IBOutlet weak var addExercise_SLD_break: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addExercise_LBL_sets.text = "Sets: \(Int(addExercise_STP_sets.value))"
        addExercise_LBL_reps.text = "Reps: \(Int(addExercise_STP_reps.value))"
        addExercise_LBL_weight.text = "Weight: \(Int(addExercise_SLD_weight.value))"
        addExercise_LBL_break.text = "Break: \(Int(addExercise_SLD_break.value))"
    }
    
    
    
    @IBAction func stepper_sets_change(_ sender: Any) {
        addExercise_LBL_sets.text = "Sets: \(Int(addExercise_STP_sets.value))"
    }
    
    
    @IBAction func stepper_reps_change(_ sender: Any) {
        addExercise_LBL_reps.text = "Reps: \(Int(addExercise_STP_reps.value))"
    }
    
    
    @IBAction func slider_weight_change(_ sender: Any) {
        addExercise_LBL_weight.text = "Weight: \(Int(addExercise_SLD_weight.value))"
    }
    
    
    @IBAction func slider_break_change(_ sender: Any) {
        addExercise_LBL_break.text = "Break: \(Int(addExercise_SLD_break.value))"
    }
    
    
    @IBAction func unwindToPreviousViewController(segue: UIStoryboardSegue) {
        let exercise = Exercise(
            name: addExercise_TF_name.text!,
            numberOfSets: Int(addExercise_STP_sets.value),
            numberOfReps: Int(addExercise_STP_reps.value),
            weight: Double(addExercise_SLD_weight.value),
            image: "", breakTime: Int(addExercise_SLD_break.value)
        )
        
        print(exercise.toDictionary())
        
        
        
        if addExercise_TF_name.text == "" {
            return
        }
        
        if addExercise_STP_sets.value == 0 {
            return
        }
        
        if addExercise_STP_reps.value == 0 {
            return
        }
        
        if addExercise_SLD_weight.value == 0 {
            return
        }
    
        
        // move data to the previous view controller
        let previousVC = self.presentingViewController as! ViewControllerCreateWorkout
        previousVC.exercises.append(exercise)
        previousVC.createWorkout_TBV_exercises.reloadData()
        
        // return to the previous view controller
        self.dismiss(animated: true, completion: nil)
    }

    
    
    
    
    
}
