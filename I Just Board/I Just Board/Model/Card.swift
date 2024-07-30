//
//  Card.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

import SwiftData

struct Card: Identifiable, Codable, Hashable {
    static private let lastIndexKey = "card.keys.index"

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id && 
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.index == rhs.index
    }
    
    var id = UUID()
    var name: String
    var description: String    
    var index: Int
    
    init(name: String, description: String) {
        self.id = UUID()
           self.name = name
           self.description = description
           self.index = Card.incrementIndex()
       }
    
    private static func incrementIndex() -> Int {
         let currentIndex = UserDefaults.standard.integer(forKey: lastIndexKey)
         let newIndex = currentIndex + 1
         UserDefaults.standard.set(newIndex, forKey: lastIndexKey)
         return newIndex
     }
     
     // Method to reset the index (if needed)
     static func resetIndex() {
         UserDefaults.standard.set(0, forKey: lastIndexKey)
     }

}
