import Foundation

class Workout {
    var id: String
    var name: String
    var exercises: [Exercise]
    
    init(id: String, name: String, exercises: [Exercise]) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
}
