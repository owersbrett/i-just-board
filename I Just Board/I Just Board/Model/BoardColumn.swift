//
//  BoardColumn.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftData

struct BoardColumn: Identifiable, Codable, Hashable {

    
    static func == (lhs: BoardColumn, rhs: BoardColumn) -> Bool {
        return lhs.id == rhs.id &&
        lhs.cards.elementsEqual(rhs.cards) &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.index == rhs.index
    }
    
    init(name: String, description: String, cards: [Card], index: Int) {
        self.id = UUID()
           self.name = name
           self.description = description
           self.cards = cards
           self.index = index
       }

    
    // Method to reset the index (if needed)

    var id: UUID
    var index: Int
    var name: String
    var description: String
    var cards: [Card]
    
    
}

