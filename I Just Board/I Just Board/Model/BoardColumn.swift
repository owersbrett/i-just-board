//
//  BoardColumn.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftData

final class BoardColumn: Identifiable, PersistentModel {
    required init(backingData: any BackingData<BoardColumn>) {
        id = backingData.getValue(forKey: \BoardColumn.id)
        name = backingData.getValue(forKey: \BoardColumn.name)
        cards = backingData.getValue(forKey: \BoardColumn.cards)
        persistentBackingData = backingData
    }
    
    static func createDefault() -> BoardColumn{
        let backingData = any BackingData<BoardColumn>.init(id: UUID(), name: "New Column", cards: [])
        let boardColumn = BoardColumn(backingData: backingData)
        return boardColumn
    }
    
    var persistentBackingData: any BackingData<BoardColumn>
    
    static var schemaMetadata: [Schema.PropertyMetadata] = [
        .init(name: "id", keypath: \BoardColumn.id),
        .init(name: "name", keypath: \BoardColumn.name),
        .init(name: "cards", keypath: \BoardColumn.cards)
    ]
    
    var id = UUID()
    var name: String = ""
    var cards: [Card] = []
}

