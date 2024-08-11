import Foundation

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
            "exercises": self.exercises.map { $0.toDictionary }
        ]
    }
}
