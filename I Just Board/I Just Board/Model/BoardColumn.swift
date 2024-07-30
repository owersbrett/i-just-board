//
//  BoardColumn.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftData

struct BoardColumn: Identifiable, Codable, Hashable {
    static private let lastIndexKey = "boardColumn.keys.index"

    
    static func == (lhs: BoardColumn, rhs: BoardColumn) -> Bool {
        return lhs.id == rhs.id &&
        lhs.cards == rhs.cards &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.index == rhs.index
    }
    
    init(name: String, description: String, cards: [Card]) {
        self.id = UUID()
           self.name = name
           self.description = description
           self.cards = cards
           self.index = BoardColumn.incrementIndex()
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
    var id: UUID
    var index: Int
    var name: String
    var description: String
    var cards: [Card]
    
    
}

