//
//  Board.swift
//  I Just Board
//Referencing instance method 'setValue(forKey:to:)' on 'Array' requires that 'BoardColumn' conform to 'PersistentModel'
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftData


struct Board: Identifiable, Codable, Hashable {
    static private let lastIndexKey = "board.keys.index"

    static func == (lhs: Board, rhs: Board) -> Bool {
        return lhs.id == rhs.id &&
        lhs.boardColumns == rhs.boardColumns &&
        lhs.description == rhs.description &&
        lhs.name == rhs.name &&
        lhs.index == rhs.index
    }
    
    var id: UUID
    var name: String
    var description: String
    var boardColumns: [BoardColumn]
    var index: Int

    // Default initializer
       init(name: String, description: String, boardColumns: [BoardColumn]) {
           self.id = UUID()
           self.name = name
           self.description = description
           self.boardColumns = boardColumns
           self.index = Board.incrementIndex()
       }
    
    
    // Method to increment the index
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


