//
//  AuthManager.swift
//  GymTimer
//
//  Created by Yaniv Ben David on 12/08/2024.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private init() {
        
    }
    
    func getCurrentUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    func isLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
    
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
        }
    }
}
