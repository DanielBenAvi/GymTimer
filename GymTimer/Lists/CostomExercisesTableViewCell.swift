//
//  CostomExercisesTableViewCell.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import Foundation
import UIKit

class CostomExercisesTableViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with object: Exercise) {
        titleLabel.text = object.name
    }

}

