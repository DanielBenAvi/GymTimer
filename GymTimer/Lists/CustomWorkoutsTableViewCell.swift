//
//  CustomWorkoutsTableViewCell.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import Foundation
import UIKit

class CustomWorkoutsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with object: Workout) {
        titleLabel.text = object.name
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        // set background color
        backgroundColor = UIColor(named: "MyPrimary")
        
        // Set corner radius
        layer.cornerRadius = 8.0 // Adjust radius as needed
        
        // Add padding inside the cell
        let inset: CGFloat = 8.0 // Adjust the value as needed
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }
    
    
}
