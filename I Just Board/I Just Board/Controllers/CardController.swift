//
//  CardController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

class CardController: ObservableObject  {
    @Published var card: Card = Card.createDefault()

    func updateCardName(cardName: String)  {
        self.card.cardName = cardName
    }
    func updateCardDescription(cardDescription: String)  {
        self.card.cardDescription = cardDescription
    }
}
