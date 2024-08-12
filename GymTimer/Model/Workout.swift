import Foundation
import FirebaseDatabase

class Workout {
    var id: String
    var name: String
    var exercises: [Exercise]
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.exercises = []
    }
    
    
    func toDictionary() -> [String: Any] {
        return [
            "id": self.id,
            "name": self.name,
            "exercises": self.exercises.map { $0.toDictionary() }
        ]
    }
    
    
    func setExercises(exercises: [Exercise]) {
        self.exercises = exercises
    }
    
    func addExercise(exercise: Exercise) {
        self.exercises.append(exercise)
    }
    
    func saveWorkoutToDB(userId: String) {
        print("saving workout to db of user: \(userId)")
        print(self.toDictionary())
        
        
        
        let ref = Database.database().reference()
        ref.child("users").child(userId).child("workouts").child(self.id).setValue(self.toDictionary())
    }
    
    
    
}
