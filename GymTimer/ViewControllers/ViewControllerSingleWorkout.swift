import Foundation
import UIKit

class ViewControllerSingleWorkout: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var workout_TBV_data: UITableView!
        
    @IBOutlet weak var workout_LBL_name: UINavigationItem!
    
    var workout: Workout!
    var exercises: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workout_LBL_name.title = workout.name
    
        workout_TBV_data.delegate = self
        workout_TBV_data.dataSource = self
        
        exercises = workout.exercises
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func startWorkout(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerWorkoutTimer") as! ViewControllerWorkoutTimer
        vc.workout = workout
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomExerciseInViewWorkoutCell", for: indexPath) as! CustomExerciseInViewWorkoutCell
        
        let object = exercises[indexPath.row]
        
        cell.configure(with: object)
        
        return cell
    }
    
}

