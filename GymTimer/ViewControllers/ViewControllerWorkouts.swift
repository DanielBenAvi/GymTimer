import Foundation
import UIKit

class ViewControllerWorkouts: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var workouts_TBV_workoutsList: UITableView!
    
    var workouts: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = AuthManager.shared.getCurrentUserId()
        
        workouts_TBV_workoutsList.delegate = self
        workouts_TBV_workoutsList.dataSource = self
        
        Task {
            
            let fromDB = await RealTimeManager.shared.getWorkoutsFromDB(userId: userId)
            
            for workout in fromDB {
                workouts.append(workout)
            }
            
            workouts_TBV_workoutsList.reloadData()
        }
        
    }
    
    @IBAction func create_workout(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ViewControllerCreateWorkout") as! ViewControllerCreateWorkout
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func preformSegue(identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: self)
    }
    
    @IBAction func logout(_ sender: Any) {
//        AuthManager.shared.logout()
//        self.moveToNewScreen(storyboard_id: "ViewControllerLogin", fullScreen: true)
        
        self.moveToNewScreen(storyboard_id: "ViewControllerProfile", fullScreen: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = workouts[indexPath.row]
        onClickCell(workout: workout)
    }
    
    func onClickCell(workout: Workout) {
        let vc = storyboard?.instantiateViewController(identifier: "ViewControllerSingleWorkout") as! ViewControllerSingleWorkout
        vc.workout = workout
        vc.modalPresentationStyle = .fullScreen // or .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }

}
