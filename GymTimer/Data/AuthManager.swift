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
}
