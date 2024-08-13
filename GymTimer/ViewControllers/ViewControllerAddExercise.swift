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
    @IBOutlet weak var addExercise_STP_weight: UIStepper!
    
    @IBOutlet weak var addExercise_LBL_break: UILabel!
    @IBOutlet weak var addExercise_STP_break: UIStepper!

    @IBOutlet weak var collectionVIew: UICollectionView!
    
    var selectedIcon: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSets()
        updateReps()
        updateWeight()
        updateBreak()
        
        collectionVIew.dataSource = self
        collectionVIew.delegate = self

    }
    
    

    
    @IBAction func stepper_sets_change(_ sender: Any) {
        updateSets()
    }
    
    
    @IBAction func stepper_reps_change(_ sender: Any) {
        updateReps()
    }
    
    
    @IBAction func stepper_weight_change(_ sender: Any) {
        updateWeight()
    }
    
    
    @IBAction func stepper_break_change(_ sender: Any) {
        updateBreak()
    }
    
    
    @IBAction func unwindToPreviousViewController(segue: UIStoryboardSegue) {
        if Valudation.shared.isEmpty(text: addExercise_TF_name.text!) {
            addAlert(title: "Error", message: "Name is empty")
            return
        }
        
        let exercise = Exercise(
            name: addExercise_TF_name.text!,
            numberOfSets: Int(addExercise_STP_sets.value),
            numberOfReps: Int(addExercise_STP_reps.value),
            weight: Double(addExercise_STP_weight.value),
            image: selectedIcon,
            breakTime: Int(addExercise_STP_break.value)
        )
        
        let previousVC = self.presentingViewController as! ViewControllerCreateWorkout
        previousVC.exercises.append(exercise)
        
        if previousVC.createWorkout_TBV_exercises.hasUncommittedUpdates {
            return
        }
        previousVC.createWorkout_TBV_exercises.reloadData()
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewControllerAddExercise {
    func updateSets() {
        addExercise_LBL_sets.text = "Sets: \(Int(addExercise_STP_sets.value))"
    }
    
    func updateReps() {
        addExercise_LBL_reps.text = "Reps: \(Int(addExercise_STP_reps.value))"
    }
    
    func updateWeight() {
        addExercise_LBL_weight.text = "Weight: \(Int(addExercise_STP_weight.value)) kg"
    }
    
    func updateBreak() {
        addExercise_LBL_break.text = "Break: \(Int(addExercise_STP_break.value)) sec"
    }
}


extension ViewControllerAddExercise : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.setIcon(iconName: "icon\(indexPath.row + 1)")
        
        return cell
      }
    
    // UICollectionViewDelegate method to handle the tap on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // uncolor all the cells
        for cell in collectionView.visibleCells {
            cell.backgroundColor = UIColor.clear
        }
        
        
        // color the selected cell
        let cell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = UIColor(named: "MyPrimary")
        
        // set the selected icon
        selectedIcon = "icon\(indexPath.row + 1)"
        print(selectedIcon)
    }
}

class MyCollectionViewCell: UICollectionViewCell {
      
    @IBOutlet weak var icon: UIImageView!
    
    func setIcon(iconName: String) {
        icon.image = UIImage(named: iconName)
    }
    
}

