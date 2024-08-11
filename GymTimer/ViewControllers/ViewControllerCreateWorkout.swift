//
//  ViewControllerCreateWorkout.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import Foundation
import UIKit

class ViewControllerCreateWorkout: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
            
    @IBOutlet weak var createWorkout_TBV_exercises: UITableView!
    
    var exercises: [Exercise] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        exercises = [
            Exercise(name: "Exercise 1", numberOfSets: 3, numberOfReps: 10, weight: 50,image: "", breakTime: 60),
            Exercise(name: "Exercise 2", numberOfSets: 3, numberOfReps: 10, weight: 50,image: "", breakTime: 60),
        ]
        
        createWorkout_TBV_exercises.delegate = self
        createWorkout_TBV_exercises.dataSource = self
        
    }
    
    
    @IBAction func add_new_exercise(_ sender: Any) {
        
        self.moveToNewScreen(storyboard_id: "ViewControllerAddExercise")
        
    }
}

extension ViewControllerCreateWorkout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostomExercisesTableViewCell", for: indexPath) as! CostomExercisesTableViewCell
        let object = exercises[indexPath.row]
        cell.configure(with: object)
        return cell
    }
}
