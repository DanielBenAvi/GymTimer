import Foundation

class Exercise {
    var id: String
    var name: String
    var numberOfSets: Int
    var numberOfReps: Int
    var weight: Double // if the weight is 0, it means the user is using body weight
    var image: String
    var breakTime: Int // in seconds
    
    init(name: String, numberOfSets: Int, numberOfReps: Int, weight: Double, image: String, breakTime: Int) {
        self.id = UUID().uuidString
        self.name = name
        self.numberOfSets = numberOfSets
        self.numberOfReps = numberOfReps
        self.weight = weight
        self.image = image
        self.breakTime = breakTime
    }
    
    init(id: String, name: String, numberOfSets: Int, numberOfReps: Int, weight: Double, image: String, breakTime: Int) {
        self.id = id
        self.name = name
        self.numberOfSets = numberOfSets
        self.numberOfReps = numberOfReps
        self.weight = weight
        self.image = image
        self.breakTime = breakTime
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": self.id,
            "name": self.name,
            "numberOfSets": self.numberOfSets,
            "numberOfReps": self.numberOfReps,
            "weight": self.weight,
            "image": self.image,
            "breakTime": self.breakTime
        ]
    }
    
}
