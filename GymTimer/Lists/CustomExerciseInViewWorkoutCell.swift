//
//  CustomExerciseInViewWorkoutCell.swift
//  GymTimer
//
//  Created by Yaniv Ben David on 12/08/2024.
//

import Foundation
import UIKit

class CustomExerciseInViewWorkoutCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with object: Exercise) {
        titleLabel.text = object.name
    }

}
