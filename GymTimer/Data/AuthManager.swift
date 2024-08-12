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
    
//    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if error == nil {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
//    }
//    
//    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            if error == nil {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
//    }
}
