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
        return lhs.id.uuidString == rhs.id.uuidString && lhs.cards == rhs.cards
    }
    
    var id = UUID()
    var name: String
    var description: String
    var cards: [Card]
    
    
}

