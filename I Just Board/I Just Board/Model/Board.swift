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
        return lhs.id.uuidString == rhs.id.uuidString && lhs.boardColumns.count == rhs.boardColumns.count
    }
    
    var id = UUID()
    var name: String
    var description: String
    var boardColumns: [BoardColumn]

    
    
//    var boardColumns: [BoardColumn] = []
//    var createDate: Date
//    var updateDate: Date
//    var boardName: String
//    var boardDescription: String
//    
//    var persistentBackingData: any BackingData<Board>

    
}


