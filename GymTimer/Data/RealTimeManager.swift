//
//  RealTimeManager.swift
//  GymTimer
//
//  Created by Yaniv Ben David on 12/08/2024.
//

import Foundation
import FirebaseDatabase

class RealTimeManager {
    static let shared = RealTimeManager()
    
    let ref = Database.database().reference()
    
    private init() {
        
    }
    
    func getUserRef(userId: String) -> DatabaseReference {
        return ref.child("users").child(userId)
    }
    
    func saveUserToDB(user: User) {
        self.getUserRef(userId: user.id).setValue(user.toDictionary())
    }
    
    func saveWorkoutToDB(workout: Workout, userId: String) {
        self.getUserRef(userId: userId).child("workouts").child(workout.id).setValue(workout.toDictionary())
    }
    
    func getUserFromDB(userId: String) async -> User? {
        do {
            let snapshot = try await self.getUserRef(userId: userId).getData()
            
            let user = snapshot.value as! [String: Any]
            
            return User(id: user["id"] as! String, name: user["name"] as! String, email: user["email"] as! String, password: user["password"] as! String)
            
        } catch {
            print("Error getting user from DB")
            return nil
        }
    }
    
    func getWorkoutsFromDB(userId: String) async -> [Workout] {
        do {
            let snapshot = try await self.getUserRef(userId: userId).child("workouts").getData()
            
            let workouts = snapshot.value as! [String: Any]
            
            return workouts.map { (key, value) in
                let workout = value as! [String: Any]
                return Workout(name: workout["name"] as! String)
            }
            
        } catch {
            print("Error getting workouts from DB")
            return []
        }
    }
}
