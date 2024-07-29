//
//  Card.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

import SwiftData

final class Card: Identifiable, PersistentModel {
    required init(backingData: any BackingData<Card>) {
        id = backingData.getValue(forKey: \Card.id)
        createDate = backingData.getValue(forKey: \Card.createDate)
        updateDate = backingData.getValue(forKey: \Card.updateDate)
        cardName = backingData.getValue(forKey: \Card.cardName)
        cardDescription = backingData.getValue(forKey: \Card.cardDescription)
        persistentBackingData = backingData
    }
    
    var persistentBackingData: any BackingData<Card>
    
    static var schemaMetadata: [Schema.PropertyMetadata] = [
        .init(name: "id", keypath: \Card.id)
        .init(name: "createDate", keypath: \Card.createDate)
        .init(name: "updateDate", keypath: \Card.updateDate)
        .init(name: "cardName", keypath: \Card.cardName)
        .init(name: "cardDescription", keypath: \Card.cardDescription)
    
    ]
    
    static func createDefault() -> Card {
        let backingData = any BackingData<Card>.init(id: UUID(), cardName: "I just a card name", boardDescription: "I just a card description", updateDate: Date(), createDate: Date(), )
        let board = Board(backingData: backingData)
        return board
    }
    
    
    
    var id = UUID()
    var createDate: Date
    var updateDate: Date
    var cardName: String
    var cardDescription: String
    

}
