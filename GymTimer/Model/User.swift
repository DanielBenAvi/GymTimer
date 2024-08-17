import Foundation
import FirebaseDatabase

class User {
    var id: String
    var name: String
    var email: String
    var password: String
    var image: String
    var workouts: [Workout]
    
    init(id: String, name: String, email: String, password: String, image: String, workouts: [Workout]) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.image = image
        self.workouts = workouts
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
    
    func getUserFromDB(userId: String) async {
        do {
            let ref = Database.database().reference()
            let snapshot = try await ref.child("users").child(userId).getData()
            
            let user = snapshot.value as! [String: Any]
            
            print("\(user)")
            
        } catch {
            print("Error getting user from DB")
        }
    }
    
}


