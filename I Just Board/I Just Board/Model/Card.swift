//
//  Card.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

import SwiftData

@Model
final class Card {
    var createDate: Date
    var updateDate: Date
    var cardName: String
    var cardDescription: String
    
    
    
    init(cardName: String, cardDescription: String) {
        self.createDate = Date()
        self.updateDate = Date()
        self.cardName = cardName
        self.cardDescription = cardDescription
    }
}
