//
//  ViewControllerCreateWorkout.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase


class ViewControllerCreateWorkout: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
            
    @IBOutlet weak var createWorkout_TF_name: UITextField!
    @IBOutlet weak var createWorkout_TBV_exercises: UITableView!
    
    var exercises: [Exercise] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        createWorkout_TBV_exercises.delegate = self
        createWorkout_TBV_exercises.dataSource = self
        
    }
    
    
    @IBAction func save_workout(_ sender: Any) {
        
        let userId = Auth.auth().currentUser!.uid
    
        let workout = Workout(name: createWorkout_TF_name.text!)
        workout.setExercises(exercises: exercises)
        
        
        workout.saveWorkoutToDB(userId: userId)
        
        self.dismiss(animated: true, completion: nil)
        
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
