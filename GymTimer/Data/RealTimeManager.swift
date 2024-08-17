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
            
            var workouts: [Workout] = []
            workouts = await self.getWorkoutsFromDB(userId: userId)
            
            
            print("workouts: \(workouts)")
            
            return User(id: user["id"] as! String, name: user["name"] as! String, email: user["email"] as! String, password: user["password"] as! String, image: user["image"] as! String, workouts: workouts)
            
        } catch {
            print("Error getting user from DB")
            return nil
        }
    }
    
    func getWorkoutsFromDB(userId: String) async -> [Workout] {
        do {
            let ref = self.getUserRef(userId: userId).child("workouts")
            print("ref: \(ref)")
            let snapshot = try await ref.getData()
            print("snapshot: \(snapshot)")
            guard let value = snapshot.value as? [String: Any] else {
                return []
            }
            var workoutssss: [Workout] = []
            
            for (_, value) in value {
                guard let workout = value as? [String: Any] else {
                    continue
                }
                let id = workout["id"] as! String
                let name = workout["name"] as! String
                var exercises: [Exercise] = []
                
                for exercise in workout["exercises"] as! [[String: Any]] {
                    let id = exercise["id"] as! String
                    let name = exercise["name"] as! String
                    let numberOfSets = exercise["numberOfSets"] as! Int
                    let numberOfReps = exercise["numberOfReps"] as! Int
                    let weight = exercise["weight"] as! Double
                    let image = exercise["image"] as! String
                    let breakTime = exercise["breakTime"] as! Int
                    
                    let exercise = Exercise(id: id, name: name, numberOfSets: numberOfSets, numberOfReps: numberOfReps, weight: weight, image: image, breakTime: breakTime)
                    exercises.append(exercise)
                }
                
                let newWorkout = Workout(name: name)
                newWorkout.id = id
                newWorkout.exercises = exercises
                workoutssss.append(newWorkout)
            }
            print("workoutssss: \(workoutssss)")
            return workoutssss
            
        } catch {
            print("Error getting workouts from DB")
            return []
        }
    }
    
    func updateUser(userId: String, userData: [String: Any]) async throws {
        let ref = Database.database().reference().child("users").child(userId)
        
        var updatedUserData = userData
        
        // Check if there are workouts in the userData
        if let workouts = userData["workouts"] as? [[String: Any]] {
            // Remove workouts from the main userData dictionary
            updatedUserData.removeValue(forKey: "workouts")
            
            // Create a separate updates dictionary for workouts
            var workoutUpdates: [String: Any] = [:]
            
            for workout in workouts {
                if let workoutId = workout["id"] as? String {
                    workoutUpdates["workouts/\(workoutId)"] = workout
                }
            }
            
            // Update the main user data
            try await ref.updateChildValues(updatedUserData)
            
            // Update the workouts separately
            if !workoutUpdates.isEmpty {
                try await ref.updateChildValues(workoutUpdates)
            }
        } else {
            // If there are no workouts, just update the user data as before
            try await ref.updateChildValues(updatedUserData)
        }
    }
}
