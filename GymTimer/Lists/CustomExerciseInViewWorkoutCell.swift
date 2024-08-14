//
//  CustomExerciseInViewWorkoutCell.swift
//  GymTimer
//
//  Created by Yaniv Ben David on 12/08/2024.
//

import Foundation
import UIKit

class CustomExerciseInViewWorkoutCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfSets: UILabel!
    @IBOutlet weak var numberOfReps: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var breakTime: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    
    
    func configure(with object: Exercise) {
        titleLabel.text = object.name
        if object.image != "" {
            icon.image = UIImage(named: object.image)
        }
        numberOfSets.text = "Sets: \(object.numberOfSets)"
        numberOfReps.text = "Reps: \(object.numberOfReps)"
        weight.text = "Weight: \(object.weight) Kg"
        breakTime.text = "Break: \(object.breakTime) Sec"
    }
    
    // Make the icon round
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.layer.cornerRadius = icon.frame.size.width / 2
        icon.clipsToBounds = true
        
        // Add border
        icon.layer.borderWidth = 1.0
        icon.layer.borderColor = UIColor(named: "MyPrimary")?.cgColor
        
        
        // cell height
        self.frame.size.height = 120
    }

}
