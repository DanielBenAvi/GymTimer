//
//  ViewControllerWorkouts.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 11/08/2024.
//

import Foundation
import UIKit

class ViewControllerWorkouts: UIViewController , UITableViewDelegate, UITableViewDataSource{
    

    
    @IBOutlet weak var workouts_TBV_workoutsList: UITableView!
    
    var workouts: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Load workouts from DB
        
        workouts = [
            Workout(name: "Workout 1"),
            Workout(name: "Workout 2"),
            Workout(name: "Workout 3"),
        ]
        
        
        workouts_TBV_workoutsList.delegate = self
        workouts_TBV_workoutsList.dataSource = self
        
    }
    
    
    @IBAction func create_workout(_ sender: Any) {
        self.moveToNewScreen(storyboard_id: "ViewControllerCreateWorkout")
    }
}


extension ViewControllerWorkouts {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomWorkoutsTableViewCell", for: indexPath) as! CustomWorkoutsTableViewCell
        let object = workouts[indexPath.row]
        cell.configure(with: object)
        return cell
    }
}
