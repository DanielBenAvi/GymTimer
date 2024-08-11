import Foundation

class Exercise {
    var id: String
    var name: String
    var numberOfSets: Int
    var numberOfReps: Int
    var weight: Double // if the weight is 0, it means the user is using body weight
    var image: String
    var breakTime: Int // in seconds
    
    init(id: String, name: String, numberOfSets: Int, numberOfReps: Int, weight: Double, image: String, breakTime: Int) {
        self.id = id
        self.name = name
        self.numberOfSets = numberOfSets
        self.numberOfReps = numberOfReps
        self.weight = weight
        self.image = image
        self.breakTime = breakTime
    }
    
}
