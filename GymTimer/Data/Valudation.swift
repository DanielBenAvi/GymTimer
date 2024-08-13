//
//  Valudation.swift
//  GymTimer
//
//  Created by דניאל בן אבי on 13/08/2024.
//

import Foundation

class Valudation{
    static let shared = Valudation()
    private init() {}
    
    
    func isEmpty(text: String) -> Bool {
        return text.isEmpty
    }
    
    func isZero(value: Double) -> Bool {
        return value == 0
    }
    
    func isNegative(value: Double) -> Bool {
        return value < 0
    }
    
    
    
    
    
}
