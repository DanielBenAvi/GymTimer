//
//  CustomExerciseInTimerCell.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 14/08/2024.
//

import Foundation
import UIKit

class CustomExerciseInTimerCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sets: UILabel!
    @IBOutlet weak var reps: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var rest: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
        
    func configure(with exerciseProg: ExerciseProgress) {
        title.text = exerciseProg.exercise.name
        sets.text = "Sets: \(exerciseProg.exercise.numberOfSets)"
        reps.text = "Reps: \(exerciseProg.exercise.numberOfReps)"
        weight.text = "Weight: \(exerciseProg.exercise.weight) Kg"
        rest.text = "Rest: \(exerciseProg.exercise.breakTime) Sec"
        progress.progress = Float(exerciseProg.completed) / Float(exerciseProg.exercise.numberOfSets)
    }
    
    func updateProgress(progress: Float){
        self.progress.progress = progress
    }
    
}
