import Foundation

class User {
    var id: String
    var name: String
    var email: String
    var password: String
    var image: String
    var workouts: [Workout]
    
    init(name: String, email: String, password: String) {
        self.id = ""
        self.name = name
        self.email = email
        self.password = password
        self.image = ""
        self.workouts = []
    }
    
    
    func setID(id: String) {
        self.id = id
    }
    
}


