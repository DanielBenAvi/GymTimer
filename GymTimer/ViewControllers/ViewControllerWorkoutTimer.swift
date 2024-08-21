import Foundation
import UIKit
import AudioToolbox


class ViewControllerWorkoutTimer: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var TableViewTimerExercises: UITableView!
    
    var workout: Workout!
    var exercises: [ExerciseProgress] = []
    var currentExercise: Int = -1
    var inActiveExercise: Bool = false
    var activeTimer: Bool = false
    var timer = Timer()
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        for exercise in workout.exercises {
            exercises.append(ExerciseProgress(exercise: exercise))
        }
        
        TableViewTimerExercises.delegate = self
        TableViewTimerExercises.dataSource = self
        
        startButton.isEnabled = false
    }
    
    @IBAction func startAction(_ sender: Any) {
        if currentExercise == -1 {
            addAlert(title: "No Exercise Selected", message: "Please select an exercise to start")
            return
        }
        
        if exercises[currentExercise].isCompleted() {
            addAlert(title: "Exercise Completed", message: "You have already completed this exercise")
            currentExercise = -1
            return
        }
        
        
        // end exercise
        if inActiveExercise && !activeTimer {
            let ex = exercises[currentExercise]
            ex.increment()
                       
            
            activeTimer = true
            inActiveExercise = false
            startButton.isEnabled = false
            
            let cell = TableViewTimerExercises.cellForRow(at: IndexPath(row: currentExercise, section: 0)) as! CustomExerciseInTimerCell
            cell.updateProgress(progress: Float(ex.completed) / Float(ex.exercise.numberOfSets))
            
            startButton.setTitle("00:00", for: .normal)
            startTimer()
        }
        
        // start exercise
        if !inActiveExercise && !activeTimer{
            inActiveExercise = true
            endButton.isEnabled = false
            startButton.setTitle("End Exercise", for: .normal)
        }
    }
    
    @objc func updateTimer() {
        seconds += 1
        
        let minutes = seconds / 60
        let seconds = seconds % 60
        
        
        // set button title to time
        let timeTitleFormat = String(format: "%02d:%02d", minutes, seconds)
        startButton.setTitle(timeTitleFormat, for: .normal)
        
        
        // if passed the time of the exercise
        if seconds >= exercises[currentExercise].exercise.breakTime {
            stopTimer()
        }
    }
    
    
    func stopTimer() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        timer.invalidate()
        activeTimer = false
        inActiveExercise = false
        startButton.setTitle("Start Exercise", for: .normal)
        startButton.isEnabled = true
        endButton.isEnabled = true
        seconds = 0
    }
    
    func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func endWorkout() {
        timer.invalidate()
        activeTimer = false
        inActiveExercise = false
        startButton.setTitle("Start Exercise", for: .normal)
        startButton.isEnabled = true
        seconds = 0
    }
    
    @IBAction func endWorkout(_ sender: Any) {
        endWorkout()
        moveToNewScreen(storyboard_id: "ViewControllerWorkouts", fullScreen: true)
    }
}

extension ViewControllerWorkoutTimer: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomExerciseInTimerCell", for: indexPath) as! CustomExerciseInTimerCell
        
        let object = exercises[indexPath.row]
        
        cell.configure(with: object)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath) as! CustomExerciseInTimerCell
        
        currentExercise = indexPath.row
        print("currentExercise: \(currentExercise)")

        
        
        startButton.isEnabled = true
    }
}

class ExerciseProgress {
    var exercise: Exercise
    var completed: Int
    
    init(exercise: Exercise) {
        self.exercise = exercise
        self.completed = 0
    }
    
    func increment() {
        completed += 1
    }
    
    
    func isCompleted() -> Bool {
        return completed >= exercise.numberOfSets
    }
}

