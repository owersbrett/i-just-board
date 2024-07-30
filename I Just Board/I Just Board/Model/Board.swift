//
//  Board.swift
//  I Just Board
//Referencing instance method 'setValue(forKey:to:)' on 'Array' requires that 'BoardColumn' conform to 'PersistentModel'
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftData


struct Board: Identifiable, Codable, Hashable {

    static func == (lhs: Board, rhs: Board) -> Bool {
        return lhs.id == rhs.id &&
        lhs.boardColumns.elementsEqual(rhs.boardColumns) &&
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
    init(name: String, description: String, boardColumns: [BoardColumn], index: Int) {
           self.id = UUID()
           self.name = name
           self.description = description
           self.boardColumns = boardColumns
           self.index = index
       }
    

}


