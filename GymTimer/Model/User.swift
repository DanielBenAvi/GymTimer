import Foundation

class User {
    var id: String
    var name: String
    var email: String
    var password: String
    var image: String
    var workouts: [Workout]
    
    init(id: String, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.image = ""
        self.workouts = []
    }
    
    
    func setID(id: String) {
        self.id = id
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": self.id,
            "name": self.name,
            "email": self.email,
            "password": self.password,
            "image": self.image,
            "workouts": self.workouts.map { $0.toDictionary() }
        ]
    }

    
}


