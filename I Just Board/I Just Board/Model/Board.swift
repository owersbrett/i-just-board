//
//  Board.swift
//  I Just Board
//Referencing instance method 'setValue(forKey:to:)' on 'Array' requires that 'BoardColumn' conform to 'PersistentModel'
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftData


final class Board: Identifiable, PersistentModel {
    var id = UUID()
    var boardColumns: [BoardColumn] = []
    var createDate: Date
    var updateDate: Date
    var boardName: String
    var boardDescription: String
    
    var persistentBackingData: any BackingData<Board>

    static var schemaMetadata: [Schema.PropertyMetadata] = [
        .init(name: "id", keypath: \Board.id),
        .init(name: "boardName", keypath: \Board.boardName),
        .init(name: "boardColumns", keypath: \Board.boardColumns)
        .init(name: "updateDate", keypath: \Board.updateDate)
        .init(name: "createDate", keypath: \Board.createDate)
        .init(name: "boardDescription", keypath: \Board.boardDescription)
    ]
    
    static func createDefault() -> Board {
        let backingData = any BackingData<Board>.init(id: UUID(), boardName: "I just a board name", boardDescription: "I just a board description", boardColumns: [], updateDate: Date(), createDate: Date(), )
        let board = Board(backingData: backingData)
        return board
    }
    
    required init(backingData: any BackingData<Board>) {
        id = backingData.getValue(forKey: \Board.id)
        boardName = backingData.getValue(forKey: \Board.boardName)
        boardColumns = backingData.getValue(forKey: \Board.boardColumns)
        updateDate = backingData.getValue(forKey: \Board.updateDate)
        createDate = backingData.getValue(forKey: \Board.createDate)
        boardDescription = backingData.getValue(forKey: \Board.boardDescription)
        
        persistentBackingData = backingData
    }
}


