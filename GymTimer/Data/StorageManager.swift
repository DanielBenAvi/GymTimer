//
//  StorageManager.swift
//  GymTimer
//
//  Created by Yaniv Ben David on 17/08/2024.
//

import Foundation
import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    
    let ref = Storage.storage().reference()
    
    private init() {
        
    }    
}
